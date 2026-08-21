{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Brian Spit";
      user.email = "brian@715209.net";
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = "";
      credential.helper = "store";
      init.defaultBranch = "main";
    };
    signing = {
      key = "D9F8E1599A98B06E";
      signByDefault = true;
    };
  };
}
