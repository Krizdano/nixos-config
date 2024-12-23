_:{
imports = [
  ./users.nix
  ./network.nix
  ./boot.nix
];

  hardware = {
    enableRedistributableFirmware = true; # for loading wifi and gpu firmwares properly.
    bluetooth.enable = true;
  };

  # adb
  programs.adb.enable = true;

  # control laptop screen brightness
  programs.light.enable = true;
}


