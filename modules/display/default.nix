{modules, lib, ...}:
let
  wmModules = [
    /niri/default.nix
    /hyprland/default.nix
  ];
  lockscreenModules = [
    /hyprlock.nix
  ];
  menuModules = [
    /fuzzel.nix
    /rofi/default.nix
    /wofi.nix
  ];
  idleModules = [
    /hypridle.nix
  ];
  notificationModules = [
    /dunst.nix
    /mako.nix
  ];
in
{
  imports = with modules; [

  ] ++ map (module: wms + module) wmModules
    ++ map (module: menus + module) menuModules
    ++ map (module: idle-daemons + module) idleModules
    ++ map (module: notification-daemons + module) notificationModules
    ++ map (module: lockscreens + module) lockscreenModules;

  options.display = {
    wms = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    menu = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    idle-daemon = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    lockscreen = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    notifications = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
}
