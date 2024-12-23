{ pkgs, lib, config, ... }:{
  options.boot.disableBuiltinKeyboard = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = {
    # Bootloader.
    boot = {
      kernelParams = lib.mkIf (config.boot.disableBuiltinKeyboard) [
        # Disable bultin keyboard because it is faulty
        "i8042.nokbd"
      ];
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
  };
}
