{
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
}
