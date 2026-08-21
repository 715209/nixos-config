{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["seven"];
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        runAsRoot = true;
    };
  };
}
