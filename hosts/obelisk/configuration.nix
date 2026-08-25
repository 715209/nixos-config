{ pkgs, lib, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../nixos/modules
    ../../nixos/modules/desktop.nix
    ../../nixos/modules/gaming.nix
    ../../nixos/modules/vm.nix

    # Services
    ../../nixos/modules/services/docker.nix
    ../../nixos/modules/services/tailscale.nix

    # Hardware
    ../../nixos/modules/hardware/nvidia.nix
    ../../nixos/modules/hardware/logitech.nix
    ../../nixos/modules/vfio.nix
  ];

  networking.hostName = hostname; 
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  time.timeZone = "Europe/Amsterdam";

  # Must match your NixOS release version for older options to remain compatible
  system.stateVersion = "24.11";
}

