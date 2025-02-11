{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.11";
  xdg.enable = true;

  home.packages = [
    pkgs.firefox
    pkgs.htop
    pkgs.ripgrep
    pkgs.ghostty
    pkgs.vscode
  ];

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "ghostty/config".text = builtins.readFile ./ghostty;
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      # language servers
      lua-language-server
      rust-analyzer
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/colors.lua}
      ${builtins.readFile ./nvim/remap.lua}
      ${builtins.readFile ./nvim/set.lua}
      ${builtins.readFile ./nvim/plugins/lsp.lua}
    '';
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

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Brian Spit";
        email = "brian@715209.net";
      };
      signing = {
        sign-all = true;
        backend = "gpg";
      };
      ui = {
        default-command = "log";
      };
    };
  };

  programs.tmux = {
    enable = true;
  };

  programs.direnv= {
    enable = true;
  };
}
