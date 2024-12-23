{ lib, config, ... }: {
  options.browsers.qute = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf (config.browsers.qute) {
    programs.qutebrowser = {
      enable = true;
      keyBindings = {
        normal = {
          "z" = "hint links spawn --detach mpv {hint-url}";
          "cs" = "config-source";
        };
      };
      settings = {
        statusbar.show = "in-mode";
        tabs.show = "switching";
        tabs.position = "left";
        scrolling.bar = "when-searching";
        url.default_page = "about:blank";
        url.start_pages = "about:blank";
        colors.webpage.preferred_color_scheme = "dark";
      };
      extraConfig = ''
        config.source('themes/city-light-theme.py')
        config.set("colors.webpage.darkmode.enabled", True)
        config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
      '';
    };
  };
}
