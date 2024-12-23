{lib, ...}: {
  imports = [
    ./sddm.nix
    ./gdm.nix
    ./greetd.nix
  ];
  options.display.greeter = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
}
