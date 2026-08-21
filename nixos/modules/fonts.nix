{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    terminus_font
    uw-ttyp0
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    hack-font
  ];
}
