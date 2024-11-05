{ pkgs, ... }:  {
  systemd.user = {
    services = {
      sortfiles = {
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = [ "${pkgs.scripts}/bin/sortfiles" ];
          Type = [ "exec" ];
        };
        Unit = {
          After = [ "graphical-session.target" ];
          Description = "Sortfiles Shell Script";
          PartOf = [ "graphical-session.target" ];
        };
      };

      batlevel = {
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = [ "${pkgs.scripts}/bin/ut bat_level" ];
          Type = [ "exec" ];
        };
        Unit = {
          After = [ "graphical-session.target" ];
          Description = "Show battery warnings";
          PartOf = [ "graphical-session.target" ];
        };
      };

      chpaper = {
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = [ "${pkgs.scripts}/bin/chpaper" ];
          Type = [ "exec" ];
        };
        Unit = {
          After = [ "graphical-session.target" ];
          Description = "Wallpaper daemon";
          PartOf = [ "graphical-session.target" ];
        };
      };
    };
  };
}
