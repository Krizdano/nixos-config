{dirs, ... }:
let
  serviceFiles = [
    "/greetd.nix"
    "/resolved.nix"
    "/nix-daemon.nix"
  ];
in
{
  imports = [
    (dirs.common + "/default.nix")
  ] ++ map (file: dirs.services + file) serviceFiles;

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
