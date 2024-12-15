{ dirs, packages,  ... }:
let
  homeFiles = [
    "/default.nix"
    "/persist.nix"
  ];
  wmFiles = [
    "/hyprland/default.nix"
    "/niri/default.nix"
  ];
in
  {
    imports = [

    ] ++ (import dirs.services)
      ++ map (file: dirs.home + file) homeFiles
      ++ map (file: dirs.wms + file) wmFiles;

    home.packages = packages.felix;
  }
