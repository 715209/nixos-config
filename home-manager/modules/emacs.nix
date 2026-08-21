{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
      extraPackages = epkgs: with epkgs; [
        evil
      ];
    extraConfig = ''
      ;; Start Evil Mode as soon as Emacs opens
      (require 'evil)
      ;; (evil-mode 1)

      (setq inhibit-startup-screen t)       ;; Main screen flag
      (setq inhibit-startup-message t)      ;; Older fallback flag
      (setq inhibit-flash-screen t)         ;; GUI splash flag
      (setq initial-scratch-message nil)    ;; Clears the note text inside the *scratch* buffer
      ;; (global-display-line-numbers-mode 1)  

      (tool-bar-mode -1)
      (menu-bar-mode -1)
    '';
  };
}
