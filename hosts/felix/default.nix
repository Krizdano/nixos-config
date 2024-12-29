{pkgs, modules, ...}: {
  imports = with modules; [
    persist
    common
    greeters
    plymouth
  ] ++ import hardware;

  network = {
    enable = true;
    enablePrivateDNS = true;
  };

  persist = {
    enable = true;
    enableForHome = true;
  };

  graphics.amdgpuSupport.enable = true;
  display.greeter = "greetd";
  disks.setupEncryptedBtrfs = true;

  #qemu and virt-manager
  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu.ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };
}
