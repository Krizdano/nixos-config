let
  root = ../.;
  lib = root + /lib;
  config = root + /config;
  packages = config + /packages.nix;
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
  secrets = let
    secretsPath = (root + /secrets.nix);
    secretsTemplate = (root + /templates/secrets.nix);
    warningMessage = ''MISSING FILE: file "secrets.nix" is missing. Using file "templates/secrets.nix"'';
  in
    if builtins.pathExists secretsPath then import secretsPath
    else builtins.warn warningMessage import secretsTemplate;
in {
  inherit
    root
    secrets
    lib
    config
    packages
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
