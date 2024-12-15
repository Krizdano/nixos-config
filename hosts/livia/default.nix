{ dirs, ... }:
let
  serviceFiles = [
    "/nix-daemon.nix"
    # "/plasma.nix"
    "/flatpak.nix"
    "/gnome.nix"
  ];
in{
  imports = [
    (dirs.programs + "/plymouth.nix")
    (dirs.common + "/default.nix")
  ] ++ map (file: dirs.services + file) serviceFiles;

  hardware.graphics = {
    enable = true;
 };

  boot.kernelParams = [
    # Disable bultin keyboard because it is faulty
    "i8042.nokbd"
  ];

}
