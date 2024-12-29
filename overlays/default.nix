{ stable, system }: final: prev:
{
  stable = import stable { inherit system; config.allowUnfree = true; }; # Add nixpkgs stable as an overlay

  # Custom packages not available on nixpkgs
  chpaper = prev.callPackage ../modules/programs/chpaper.nix { }; # Set and change wallpaper
  scripts = prev.callPackage ../config/scripts { }; # My personal scripts
  oi = prev.callPackage ../modules/programs/oi.nix { }; # Cli program for quick google search
  redqu = prev.callPackage ../modules/programs/redqu.nix { }; # Media centric reddit client
  toki = prev.callPackage ../modules/programs/toki.nix { }; # A command-line project manager for c and assembly
  nix-helpers = prev.callPackage ../modules/programs/nix-helpers.nix {}; # A simple script to simplify the usage of various nix commands
}
