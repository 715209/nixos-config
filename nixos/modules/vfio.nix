{ config, pkgs, ... }:

{
  # boot.initrd.kernelModules = [ 
  #   "vfio_pci"
  #   "vfio"
  #   "vfio_iommu_type1"

  #   "i915" # replace or remove with your device's driver as needed
  # ];

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "kvm.ignore_msrs=1"
  ];

  boot.kernelModules = [
    "kvm-amd"
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
    "vfio_virqfd"
  ];

  # # Bind GTX 1060 + its audio to VFIO
  # boot.extraModprobeConfig = ''
  #   options vfio-pci ids=10de:1c03,10de:10f1
  # '';

  # boot.blacklistedKernelModules = [
  #   "nouveau"
  #   "nvidia"
  #   "nvidia_drm"
  #   "nvidia_modeset"
  # ];
}
