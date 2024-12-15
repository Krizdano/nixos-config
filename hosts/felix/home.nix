{ pkgs, dirs,  ... }:
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

    home.packages = with pkgs; [
      oi # cli program for quick google search
      redqu # media centric reddit client
      keepassxc
      nitch
      virt-manager
      gdu # disk management
      tdesktop # telegram
      signal-desktop
      toot # mastodon cli client
    ];
  }
