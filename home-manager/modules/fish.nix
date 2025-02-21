{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if isatty
        set -x GPG_TTY (tty)
      end
    '';
  };
}
