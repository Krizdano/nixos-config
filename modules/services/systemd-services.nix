{ pkgs, lib, config, ... }: {
  options.services = {
    sortfiles = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    batlevel = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    chpaper = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = {
    systemd.user.services = {
      sortfiles = lib.mkIf (config.services.sortfiles) {
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
      batlevel = lib.mkIf (config.services.batlevel) {
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
      chpaper = lib.mkIf (config.services.chpaper) {
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
