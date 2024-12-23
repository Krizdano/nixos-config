{pkgs, lib, config, ...}: {
  config = lib.mkIf (builtins.elem "niri" config.display.wms)  {
    home.packages = [ pkgs.niri ];
    xdg.portal = {
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      configPackages = [ pkgs.niri ];
      config = {
        niri = {
          default = [ "gnome" "gtk" ];
        };
      };
    };

    xdg.configFile."niri/config.kdl".source = pkgs.substituteAll {
      src = ./config.kdl;
      dbus_update_activation_env_cmd = "${pkgs.dbus}/bin/dbus-update-activation-environment";
      systemctl_cmd = "${pkgs.systemd}/bin/systemctl";
    };

    systemd.user = {
      targets.niri-session = {
        Unit = {
          After = [ "graphical-session-pre.target" ];
          BindsTo = [ "graphical-session.target" ];
          Description = "Niri compositor session";
          Documentation = "man:systemd.special(7)";
          Wants = [ "graphical-session-pre.target" ];
        };
      };
    };
  };
}
