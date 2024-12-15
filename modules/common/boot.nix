{ pkgs, ... }:{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # only store 5 nixos generations
        configurationLimit = 5;
      };
      timeout = 0;
      # UEFI settings
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;  # get latest kernel
    kernel.sysctl = { "vm.swappiness" = 10; };
  };
}
