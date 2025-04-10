{ user, inputs, ... }:
{ config, pkgs, lib, ... }:

let
  unstablePkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };
in {
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
    postman
    ripgrep
    rustdesk
    tailscale
    thunderbird
    tilt
    tmux
    vscode
    unstablePkgs.obs-studio
  ];

  imports = [
    ./modules
  ];
}
