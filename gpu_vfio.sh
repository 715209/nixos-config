#!/usr/bin/env bash
# gpu-passthrough.sh — move a GPU between its host drivers and vfio-pci.
#
#   gpu-passthrough.sh vfio     bind to vfio-pci (ready for a VM)
#   gpu-passthrough.sh host     give it back to nvidia / snd_hda_intel
#   gpu-passthrough.sh status   show current driver + IOMMU group
#
# Add -f to vfio to skip the "is anything still using it" preflight.

set -euo pipefail

# --- config ------------------------------------------------------------------

DEVICES=(
    "0000:01:00.0"   # VGA
    "0000:01:00.1"   # HDMI audio
)

# --- helpers -----------------------------------------------------------------

die() { echo "error: $*" >&2; exit 1; }

driver_of() {
    local link="/sys/bus/pci/devices/$1/driver"
    [[ -L $link ]] && basename "$(readlink -f "$link")" || echo none
}

# DRM nodes (/dev/dri/*) currently exposed by a PCI device
drm_nodes_of() {
    local dev=$1 n
    for n in "/sys/bus/pci/devices/$dev/drm/"{card,renderD}*; do
        [[ -e $n ]] && echo "/dev/dri/$(basename "$n")"
    done
}

# PIDs holding any of the given device nodes open
holders_of() {
    local -a targets=("$@")
    local fd link pid t
    for fd in /proc/[0-9]*/fd/*; do
        link=$(readlink "$fd" 2>/dev/null) || continue
        for t in "${targets[@]}"; do
            if [[ $link == "$t" ]]; then
                pid=${fd#/proc/}; echo "${pid%%/*}"
                break
            fi
        done
    done | sort -un
}

rebind() {  # rebind <pci-addr> <target-driver|auto>
    local dev=$1 target=$2 cur
    cur=$(driver_of "$dev")

    if [[ $target != auto && $cur == "$target" ]]; then
        echo "  $dev already on $target"
        return
    fi

    if [[ $target == auto ]]; then
        echo "" > "/sys/bus/pci/devices/$dev/driver_override"
    else
        echo "$target" > "/sys/bus/pci/devices/$dev/driver_override"
    fi

    [[ $cur != none ]] && echo "$dev" > "/sys/bus/pci/devices/$dev/driver/unbind"
    echo "$dev" > /sys/bus/pci/drivers_probe

    echo "  $dev: $cur -> $(driver_of "$dev")"
}

check_iommu_group() {
    local dev=$1 member extra=()
    for member in "/sys/bus/pci/devices/$dev/iommu_group/devices/"*; do
        member=$(basename "$member")
        [[ " ${DEVICES[*]} " == *" $member "* ]] || extra+=("$member")
    done
    if (( ${#extra[@]} )); then
        echo "warning: IOMMU group also contains: ${extra[*]}" >&2
        echo "         these must go to vfio-pci too, or the VM will refuse the device" >&2
    fi
}

# --- commands ----------------------------------------------------------------

cmd_status() {
    local dev
    for dev in "${DEVICES[@]}"; do
        printf '%s  driver=%-14s nodes=%s\n' \
            "$dev" "$(driver_of "$dev")" "$(drm_nodes_of "$dev" | tr '\n' ' ')"
    done
    check_iommu_group "${DEVICES[0]}"
}

cmd_vfio() {
    local force=${1:-} dev
    local -a targets=() pids=()

    if [[ $force != -f ]]; then
        targets=(/dev/nvidia*)
        for dev in "${DEVICES[@]}"; do
            while read -r n; do targets+=("$n"); done < <(drm_nodes_of "$dev")
        done

        mapfile -t pids < <(holders_of "${targets[@]}")
        if (( ${#pids[@]} )); then
            echo "GPU is still open — unbinding now would hang in D state:" >&2
            ps -o pid=,comm= -p "${pids[@]}" >&2
            echo >&2
            echo "log out of your session (or stop the listed processes), then retry." >&2
            exit 1
        fi
    fi

    check_iommu_group "${DEVICES[0]}"
    modprobe vfio-pci

    echo "binding to vfio-pci..."
    for dev in "${DEVICES[@]}"; do rebind "$dev" vfio-pci; done
}

cmd_host() {
    local dev cur
    echo "returning to host drivers..."
    for dev in "${DEVICES[@]}"; do
        cur=$(driver_of "$dev")
        # Only devices actually parked on vfio-pci get touched. Unbinding a
        # device that is already on its host driver would tear the GPU out
        # from under a running session and hang in D state.
        if [[ $cur != vfio-pci ]]; then
            echo "  $dev on $cur — not vfio-pci, skipping"
            continue
        fi
        rebind "$dev" auto
    done
    echo
    echo "the DRM nodes are back; niri will pick the GPU up on the udev add event"
    echo "unless ignore-drm-device is still set for it."
}

# --- main --------------------------------------------------------------------

(( EUID == 0 )) || die "must run as root"

case "${1:-}" in
    vfio)   cmd_vfio "${2:-}" ;;
    host)   cmd_host ;;
    status) cmd_status ;;
    *)      die "usage: $(basename "$0") {vfio [-f]|host|status}" ;;
esac
