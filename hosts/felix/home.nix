{ dirs, packages,  ... }:
let
  homeModules = [
    "/default.nix"
    "/persist.nix"
  ];
  wmModules = [
    "/hyprland/default.nix"
    "/niri/default.nix"
  ];
in
  {
    imports = [

    ] ++ (import dirs.services)
      ++ map (module: dirs.home + module) homeModules
      ++ map (module: dirs.wms + module) wmModules;

    home.packages = packages.felix;
  }
