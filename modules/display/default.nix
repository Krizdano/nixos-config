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

  options.display =  with lib; with lib.types; {
    wms = mkOption {
      type = listOf str;
      default = [];
    };
    menu = mkOption {
      type = str;
      default = "";
    };
    idle-daemon = mkOption {
      type = str;
      default = "";
    };
    lockscreen = mkOption {
      type = str;
      default = "";
    };
    notifications = mkOption {
      type = str;
      default = "";
    };
  };
}
