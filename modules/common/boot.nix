{ pkgs, lib, config, ... }:{
  options.boot = with lib; with lib.types; {
    disableBuiltinKeyboard = mkOption {
      type = lib.types.bool;
      default = false;
    };
    useStableKernel = mkOption {
      type = bool;
      default = false;
    };
  };
  config = {
    # Bootloader.
    boot = {
      kernelParams = lib.mkIf config.boot.disableBuiltinKeyboard [
        # Disable bultin keyboard because it is faulty
        "i8042.nokbd"
      ];
      loader = {
        systemd-boot = {
          enable = true;
          # only store 5 nixos generations
          configurationLimit = 5;
        };
        timeout = lib.mkDefault 0;
        # UEFI settings
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
      };
      tmp.useTmpfs = true;
      kernelPackages = lib.mkIf (!config.boot.useStableKernel) pkgs.linuxPackages_latest;
      kernel.sysctl = { "vm.swappiness" = 10; };
    };
  };
}
