{ pkgs, ... }: {
  programs = {
    firefox = {
      enable = true;
      policies = import ./policies.nix;
      profiles.default = {
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
}
