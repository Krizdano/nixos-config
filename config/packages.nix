{ pkgs, ... }:
let
  common = with pkgs; [
    toki
    keepassxc
    nitch
    gdu # disk management
    scripts # my scripts
    unzip
    jmtpfs
    imv
    w3m # terminal browser
    glow # terminal markdown reader
    xdg-utils # for xdg-open to work
    wtype
    ripgrep
    wl-clipboard
    fastfetch
    disko
    nix-helpers
  ];

  felix = with pkgs; [
    oi # cli program for quick google search
    redqu # media centric reddit client
    virt-manager
    tdesktop # telegram
    signal-desktop
    toot # mastodon cli client
  ] ++ common;

  livia = with pkgs; [
    gdu # disk management
    bitwarden-desktop
    tdesktop # telegram
    signal-desktop
    ripgrep
    fastfetch
    disko
    nix-helpers
    scripts
  ];

  iso = with pkgs; [
  ] ++ common;

 fonts = {
   main = {
     name = "Iosevka Nerd Font";
     package = pkgs.nerd-fonts.iosevka;
   };
   forWaybar = {
     name = "Ubuntu Nerd Font";
     package = pkgs.nerd-fonts.ubuntu;
   };
   forHyprlock = {
     name = "FiraCode Nerd Font";
     package = pkgs.nerd-fonts.fira-code;
   };
 };
in
 {
   inherit
   common
   felix
   livia
   iso
   fonts;
}
