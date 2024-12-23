{pkgs, modules, ...}: {
  imports = with modules; [
    ./rollback.nix
    persist
    common
    greeters
    (programs + /plymouth.nix)
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
