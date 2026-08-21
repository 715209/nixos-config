{ config, pkgs, ... }:
{
  # Basic networking settings
  # networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # hardware.enableRedistributableFirmware = true;
  
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  # networking = {
  #     useDHCP = false;
  #     interfaces.enp7s0 = {
  #       ipv4.addresses = [{
  #           address = "192.168.178.2";
  #           prefixLength = 24;
  #       }];
  #   };
  #   defaultGateway = "192.168.178.1";
  #   nameservers = [ "1.1.1.1" "8.8.8.8" ];
  # };
}

