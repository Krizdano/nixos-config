{ packages, lib, config, ... }:{

  config = lib.mkIf (config.display.menu == "fuzzel") {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          prompt = "Apps ";
          icons-enabled = false;
          width = 40;
          inner-pad = 10;
          line-height = 28;
          lines = 8;
          font = "${packages.fonts.main.name}:size=14";
          use-bold = true;
          dpi-aware = "no";
        };

        colors = {
          background ="151515ff";
          text ="FFFFFFFF";
          prompt ="FFFFFFFF";
          input = "ffffffff";
          selection = "FFFFFFFF";
          selection-text = "151515ff";
          selection-match = "f7b2b2ff";
          match = "ff7575ff";
          border = "ffffffff";

        };

        border = {
          width = 2;
        };

      };
    };
  };
}
