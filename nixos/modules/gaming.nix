{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-ng

    lutris

    wineWow64Packages.stable
    winetricks
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
