{lib, config, gtkTheme, pkgs, ...}:
let
  inherit (config.xdg) configHome;
in
 {
  options.gtk.enableDarkMode = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  config = {
    gtk = {
      enable = true;
      gtk2.configLocation = "${configHome}/gtk-2.0/gtkrc";
      theme = gtkTheme;
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        size = 29;
      };
      iconTheme = {
        name = "WhiteSur-light";
        package = pkgs.whitesur-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = lib.mkIf (config.gtk.enableDarkMode) true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = lib.mkIf (config.gtk.enableDarkMode) true;
      };
    };

    dconf.settings = lib.mkIf (!config.gtk.enableDarkMode) {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-light";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };
  };
}
