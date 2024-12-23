{lib, ...}: {
  imports = [
    ./gnome.nix
    ./plasma.nix
  ];
  options.display = {
    desktopManagers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
