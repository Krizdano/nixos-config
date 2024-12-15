let
  root = ../.;
  modules = (root + "/modules");
  programs = (modules + "/programs");
  services = (modules + "/services");
  wms = (modules + "/windowmanagers");
  shells = (modules + "/shell");
  home = (modules + "/home");
  security = (modules + "/security");
  common = (modules + "/common");
  hosts = (root + "/hosts");
  felix = (hosts + "/felix");
  livia = (hosts + "/livia");
  iso = (hosts + "/iso");
in {
  inherit
    root
    modules
    programs
    services
    wms
    shells
    common
    home
    security
    hosts
    felix
    livia
    iso;
}
