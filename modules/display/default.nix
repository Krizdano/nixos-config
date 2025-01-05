{myModules, lib, ...}:
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
    imports = with myModules; map (module: wms + module) wmModules
                          ++ map (module: menus + module) menuModules
                          ++ map (module: idle-daemons + module) idleModules
                          ++ map (module: notification-daemons + module) notificationModules
                          ++ map (module: lockscreens + module) lockscreenModules;


    options.display =  with lib; with lib.types; {
      wms = mkOption {
        type = listOf str;
        default = [];
        description = "List of Window Managers to be installed";
      };
      menu = mkOption {
        type = str;
        default = ''Name of Application menu. Eg: "rofi","wofi" etc.'';
        description = "";
      };
      idle-daemon = mkOption {
        type = str;
        default = ''Name of the Idle Daemon. Eg: "hypridle","swayidle" etc.'';
        description = "";
      };
      lockscreen = mkOption {
        type = str;
        default = ''Name of lockscreen. Eg: "hyprlock" "swaylock" etc.'';
        description = "";
      };
      notifications = mkOption {
        type = str;
        default = ''Name of the notification deamon. Eg: "dunst" "mako" etc.'';
        description = "";
      };
    };
  }
