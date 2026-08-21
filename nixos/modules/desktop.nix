{ config, pkgs, inputs, ... }:
{
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # services.displayManager.defaultSession = "plasma";

  # # Enable the COSMIC login manager
  # services.displayManager.cosmic-greeter.enable = true;
  # # Enable the COSMIC desktop environment
  # services.desktopManager.cosmic.enable = true;

  services.flatpak.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # Remove later
  environment.systemPackages = [
    pkgs.wofi
    pkgs.rofi
    pkgs.hyprshot
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.dolphin
    pkgs.playerctl
    pkgs.wiremix # TUI alternative to pavucontrol
    pkgs.pavucontrol
    pkgs.fuzzel
    pkgs.xwayland-satellite
    pkgs.xdg-desktop-portal-gnome
  ];

  programs.niri.enable = true;

  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  # #   withUWSM = true;
  # };
}

