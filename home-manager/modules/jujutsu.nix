{
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
}
