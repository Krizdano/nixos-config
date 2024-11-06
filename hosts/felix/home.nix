{ pkgs, ... }: {

  imports = [
    ../../modules/home/default.nix
    ../../modules/home/persist.nix
    ../../modules/windowmanagers/hyprland/default.nix
    ../../modules/windowmanagers/niri/default.nix
  ]
  ++ (import ../../modules/services);

  home.packages = with pkgs; [
    oi # cli program for quick google search
    toki
    nix-helpers
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
