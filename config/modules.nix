let
  root = ../.;
  config = root + /config;
  themes = config + /themes.nix;
  modules = root + /modules;
  persist = modules + /persist;
  hardware = modules + /hardware;
  programs = modules + /programs;
  browsers = programs + /browsers;
  terminals = programs + /terminals;
  plymouth = programs + /plymouth.nix;
  services = modules + /services;
  display = modules + /display;
  wms = display + /window-managers;
  desktopManagers = display + /desktop-managers;
  idle-daemons = display + /idle-daemons;
  greeters = display + /greeters;
  menus = display + /application-menus;
  lockscreens = display + /lockscreens;
  notification-daemons = display + /notification-daemons;
  shells = modules + /shell;
  home = modules + /home;
  security = modules + /security;
  disko = modules + /disko;
  common = modules + /common;
  hosts = root + /hosts;
  felix = hosts + /felix;
  livia = hosts + /livia;
  iso = hosts + /iso;
in {
  inherit
    root
    config
    themes
    modules
    persist
    hardware
    programs
    browsers
    terminals
    plymouth
    services
    display
    wms
    desktopManagers
    idle-daemons
    greeters
    menus
    lockscreens
    notification-daemons
    shells
    disko
    common
    home
    security
    hosts
    felix
    livia
    iso;
}
