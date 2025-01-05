{
  description = "My personal NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs?ref=release-24.11";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stable, ... }@inputs:
    let
      myModules = import ./config/modules.nix;
      inherit (myModules.secrets) users;
      args = { inherit myModules users inputs; };
      myLib = import myModules.lib { inherit args; };
    in
      {
        nixosConfigurations = with myLib;  {
          felix = mkNixosConfig {
            hostname = "felix";
            diskoDevice = "/dev/nvme0n1";
          };
          livia = mkNixosConfig {
            hostname = "livia";
            user = users.secondary;
            themeForGtk = "adwaita";
            diskoDevice = "/dev/sda";
          };
          iso = mkNixosConfig {
            hostname = "iso";
            diskoDevice = null;
            extraModules = [
              (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ];
          };
        };
      };
}
