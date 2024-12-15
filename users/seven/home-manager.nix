{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.firefox
  ];

  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Brian Spit";
    userEmail = "brian@715209.net";
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
  };
}
