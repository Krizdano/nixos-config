{ pkgs, user, dirs, ... }:
let
  serviceModules = [
    "/greetd.nix"
    "/resolved.nix"
    "/nix-daemon.nix"
    "/flatpak.nix"
  ];
in
  {
    imports = [
      ./rollback.nix
      ../persist.nix
      (dirs.programs + "/plymouth.nix")
      (dirs.common + /default.nix )
    ] ++ map (module: dirs.services + module) serviceModules;

    hardware = {
      amdgpu = {
        opencl = {
          enable = true;
        };
        amdvlk = {
          enable = true;
          support32Bit.enable = true;
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /persist/home - ${user.userName} users -"
    ];

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
