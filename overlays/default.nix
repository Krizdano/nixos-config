final: prev:
{
  chpaper = prev.callPackage ../modules/programs/chpaper.nix { }; # Set and change wallpaper
  scripts = prev.callPackage ../config/scripts { }; # My personal scripts
  oi = prev.callPackage ../modules/programs/oi.nix { }; # Cli program for quick google search
  redqu = prev.callPackage ../modules/programs/redqu.nix { }; # Media centric reddit client
  toki = prev.callPackage ../modules/programs/toki.nix { }; # A command-line project manager for c and assembly
}
