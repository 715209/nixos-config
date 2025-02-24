{ user, ... }:
{ config, pkgs, lib, ... }:

{
  home = {
    stateVersion = "24.11";
    username = user;
    homeDirectory = "/home/${user}";
  };

  home.packages = with pkgs; [
    direnv
    firefox
    flameshot
    htop
    ripgrep
    tailscale
    thunderbird
    tmux
    vscode
  ];

  imports = [
    ./modules
  ];
}
