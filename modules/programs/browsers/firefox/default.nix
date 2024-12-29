{ pkgs, lib, config, ... }: {
  options.browsers.firefox = with lib; with lib.types; {
    enable = mkOption {
      type = bool;
      default = false;
    };
    hardened = mkOption {
      type = bool;
      default = false;
    };
    enableAdBlock = mkOption {
      type = bool;
      default = false;
    };
    enableVimSupport = mkOption {
      type = bool;
      default = false;
    };
    enableDarkMode = mkOption {
      type = bool;
      default = false;
    };
    enableBitWarden = mkOption {
      type = bool;
      default = false;
    };
    enableKeepass = mkOption {
      type = bool;
      default = false;
    };
    enableContainers = mkOption {
      type = bool;
      default = false;
    };
  };
  config = let
    cfg = config.browsers.firefox;
    isHardened = lib.mkIf cfg.hardened;
  in {
    browsers.firefox = isHardened {
      enableDarkMode = true;
      enableContainers = true;
      enableAdBlock = true;
      enableVimSupport = true;
      enableKeepass = true;
    };
    programs = lib.mkIf cfg.enable {
      firefox = {
        enable = true;
        policies = import ./policies.nix { inherit cfg lib isHardened; };
        profiles.default = {
          id = 0;
          name = "Default";
          isDefault = true;
          search = {
            force = true;
            default = if cfg.hardened then "Searx" else "Brave";
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


          settings = isHardened {
            #userChrome settings
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "layers.acceleration.force-enabled" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.enabled" = true;
            "layout.css.backdrop-filter.enabled" = true;
            "layout.css.overflow-overlay.enabled" = true;
            "svg.context-properties.content.enabled" = true;
          };
          userChrome = if cfg.hardened then builtins.readFile ./userChrome.css else {};
        };
      };
    };
  };
}
