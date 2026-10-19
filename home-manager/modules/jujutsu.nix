{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Brian Spit";
        email = "brian@715209.net";
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = "D9F8E1599A98B06E";
      };
      ui = {
        default-command = "log";
        pager = "less -FRX";
      };
    };
  };
}
