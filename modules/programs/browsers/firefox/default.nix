{ pkgs, lib, config, ... }: {
  options.browsers.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    hardened = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableAdBlock = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableVimSupport = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableDarkMode = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableBitWarden = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableKeepass = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enableContainers = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = let cfg = config.browsers.firefox; in {
    browsers.firefox = lib.mkIf cfg.hardened {
      enableDarkMode = true;
      enableContainers = true;
      enableAdBlock = true;
      enableVimSupport = true;
      enableKeepass = true;
    };
    programs = lib.mkIf (cfg.enable) {
      firefox = {
        enable = true;
        policies = (import ./policies.nix { inherit cfg lib; });
        profiles.default = lib.mkIf (cfg.hardened) {
          id = 0;
          name = "Default";
          isDefault = true;
          search = {
            force = true;
            default = "Searx";
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              "Brave" = {
                urls = [{
                  template = "https://search.brave.com/search?q={searchTerms}";
                }];
                definedAliases = [ "@br" ];
              };

              "Searx" = {
                urls = [{
                  template = "https://priv.au/search?q={searchTerms}";
                }];
                definedAliases = [ "@sx" ];
              };
            };
          };


          settings = {
            #userChrome settings
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "layers.acceleration.force-enabled" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.enabled" = true;
            "layout.css.backdrop-filter.enabled" = true;
            "layout.css.overflow-overlay.enabled" = true;
            "svg.context-properties.content.enabled" = true;
          };
          userChrome = builtins.readFile ./userChrome.css;
        };
      };
    };
  };
}
