{ user, ... }:
{ config, pkgs, lib, ... }:

{
  home = {
    stateVersion = "24.11";
    username = user;
    homeDirectory = "/home/${user}";
  };

  home.packages = with pkgs; [
    btop
    ctlptl
    direnv
    firefox
    flameshot
    htop
    kind
    kubectl
    obs-studio
    postman
    ripgrep
    rustdesk
    tailscale
    thunderbird
    tilt
    tmux
    vscode
  ];

  imports = [
    ./modules
  ];
}
