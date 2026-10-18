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
    direnv
    discord
    firefox
    flameshot
    htop
    kubectl
    postman
    ripgrep
    #rustdesk
    thunderbird
    tmux
    vscode
    tigervnc
    google-chrome
    sonobus
  ];

  imports = [
    ./modules
  ];
}
