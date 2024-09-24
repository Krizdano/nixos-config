{ pkgs, ... }:
let
  swaylock = "${pkgs.swaylock}/bin/swaylock";
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${swaylock} -fc 000000 ";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${swaylock} -fc 000000";
      }
      {
        timeout = 200;
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
      }
    ];
  };
}
