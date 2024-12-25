{ pkgs, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.seven = {
     isNormalUser = true;
     home = "/home/seven";
     extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.fish;
   };
}

