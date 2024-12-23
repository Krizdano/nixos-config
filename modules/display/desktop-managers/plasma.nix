{ lib, config, ... }: {
  config = lib.mkIf (builtins.elem "plasma" config.display.desktopManagers) {
    services = {
      xserver.enable = true;
      desktopManager.plasma6 = {
        enable = true;
      };
    };
  };
}
