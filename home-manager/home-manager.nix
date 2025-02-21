{ user, ... }:
{ config, pkgs, lib, ... }:

{
  home = {
    stateVersion = "24.11";
    username = user;
    homeDirectory = "/home/${user}";
  };

  home.packages = with pkgs; [
    firefox
    flameshot
    htop
    ripgrep
    thunderbird
    vscode
  ];

  imports = [
    ./modules
  ];
}
