{ pkgs, user, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
     #home = "/home/seven";
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "networkmanager" ];
     shell = pkgs.fish;
   };
}

