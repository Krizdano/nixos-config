{dirs, ... }:
let
  serviceModules = [
    "/greetd.nix"
    "/resolved.nix"
    "/nix-daemon.nix"
  ];
in
{
  imports = [
    (dirs.common + "/default.nix")
  ] ++ map (module: dirs.services + module) serviceModules;

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
