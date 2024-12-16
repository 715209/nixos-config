{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.firefox
  ];

  programs.neovim = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      (builtins.readFile ./config.fish)
    ]));
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;

    # Cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  programs.git = {
    enable = true;
    userName = "Brian Spit";
    userEmail = "brian@715209.net";
    signing = {
      key = "D9F8E1599A98B06E";
      signByDefault = true;
    };
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
