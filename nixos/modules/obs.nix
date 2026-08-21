{ pkgsUnstable, ... }:
{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    package = pkgsUnstable.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgsUnstable.obs-studio-plugins; [
      droidcam-obs
    ];
  };
}
