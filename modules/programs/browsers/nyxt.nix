{lib, config, pkgs, myModules, ...}:
let
  emacs = ''${config.programs.emacs.package}/bin/emacs --batch --eval "(require 'org)" --eval'';
in
  {
    options.browsers.nyxt = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    config = lib.mkIf config.browsers.nyxt {
      home.packages = [
        pkgs.nyxt
      ];

      home.activation.load-nyxt-config = config.lib.dag.entryAfter ["writeBoundary"] ''
        ${emacs} '(org-babel-tangle-file
              "${myModules.root}/docs/nyxt-config.org")'
      '';
    };
  }
