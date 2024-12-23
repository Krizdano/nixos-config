{modules, ...}:
{
  imports = with modules; [
    (common + /default.nix)
    (services + /greetd.nix)
  ] ++ map (module: services + module) serviceModules;

  network = {
    enable = true;
    privateDns = true;
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
