{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    terminus_font
  ];
}
