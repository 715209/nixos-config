{ config, pkgs, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = "experimental-features = nix-command flakes";

  # Let Nixpkgs use non-free software if needed
  nixpkgs.config.allowUnfree = true;

  # Some system-wide packages
  environment.systemPackages = with pkgs; [
    gnumake
    xclip
    killall
  ];
}

