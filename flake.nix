{
  description = "My personal NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs?ref=release-24.05";
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
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./overlays { inherit stable system; }) ];
      };
      modules = import ./config/modules.nix;
      packages = import ./config/packages.nix { inherit pkgs; };

      secrets = if builtins.pathExists (modules.root + "/secrets.nix") then
        import ./secrets.nix
      else (lib.warn ''file "secrets.nix" is missing. Using file "templates/secrets.nix"''
        import templates/secrets.nix);

      inherit (secrets) users;
      mkNixosConfig = {
        hostname,
        user ? users.primary,
        gtkTheme ? (import modules.themes {inherit pkgs;}),
        diskoDevice,
        extraModules ? []
      }:
        lib.nixosSystem
          {
            inherit system;
            specialArgs = {
              inherit
                   packages
                   modules
                   secrets
                   users
                   user
                   pkgs
                   inputs;
            };
            modules = with inputs; [
              {
                nixpkgs.hostPlatform = lib.mkDefault system;
                networking.hostName = lib.mkDefault hostname;
              }
              impermanence.nixosModules.impermanence

              disko.nixosModules.default
              ({config, ...}: {
                imports = [
                  (import modules.disko {
                    inherit lib config;
                    device = diskoDevice;
                  })
                ];
              })

              home-manager.nixosModules.home-manager
              modules.hosts
              modules.${hostname}
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit
                         modules
                         packages
                         user
                         gtkTheme
                         pkgs
                         inputs;
                  };
                  users.${user.userName} = {
                    imports = [
                      impermanence.nixosModules.home-manager.impermanence
                      nixvim.homeManagerModules.nixvim
                      (modules.${hostname} + "/home.nix")
                    ];
                  };
                };
              }
            ];
          };
    in
      {
        nixosConfigurations = {
          felix = mkNixosConfig {
            hostname = "felix";
            diskoDevice = "/dev/nvme0n1";
          };
          livia = mkNixosConfig {
            hostname = "livia";
            user = users.secondary;
            gtkTheme = {
              name = "Adwaita";
            };
            diskoDevice = "/dev/sda";
          };
          iso = mkNixosConfig {
            hostname = "iso";
          };
        };
      };
}
