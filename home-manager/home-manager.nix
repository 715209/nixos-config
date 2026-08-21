{ user, inputs, ... }:
{ config, pkgs, lib, ... }:

let
  unstablePkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
  home = {
    stateVersion = "25.11";
    username = user;
    homeDirectory = "/home/${user}";
  };

  home.packages = with pkgs; [
    btop
    ctlptl
    direnv
    discord
    firefox
    flameshot
    htop
    kind
    kubectl
    postman
    ripgrep
    #rustdesk
    thunderbird
    tilt
    tmux
    vscode
    tigervnc
    #unstablePkgs.obs-studio
    #bubblewrap
    google-chrome
  ];

  imports = [
    ./modules
  ];
}
