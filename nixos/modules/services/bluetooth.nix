{ config, pkgs, ... }:

{
  # enables support for Bluetooth
  hardware.bluetooth.enable = true; 

  # powers up the default Bluetooth controller on boot
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
