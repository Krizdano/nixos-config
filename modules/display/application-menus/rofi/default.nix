{ pkgs, lib, config, ... }: {

  config = lib.mkIf (config.display.menu == "rofi") {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland.override { symlink-dmenu = true; };
      theme = ./theme.rasi;
    };
  };
}
