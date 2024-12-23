{ config, pkgs, lib, ... }:
let
  toggle-screen = "${pkgs.scripts}/bin/toggle-screen";
  lock-session = "${pkgs.systemd}/bin/loginctl lock-session";
in
  {
    config = lib.mkIf (config.display.idle-daemon == "hypridle") {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
            unlock_cmd = "${pkgs.procps}/bin/pkill -USR1 hyprlock";
            before_sleep_cmd = lock-session;
            after_sleep_cmd = "${toggle-screen} -n Screenon";
          };
          listener = [
            {
              timeout = 120;
              on-timeout = lock-session;
            }
            {
              timeout = 160;
              on-timeout = "${toggle-screen} -n Screenoff";
              on-resume = "${toggle-screen} -n Screenon";
            }
            {
              timeout = 200;
              on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
            }
          ];
        };
      };
    };
  }
