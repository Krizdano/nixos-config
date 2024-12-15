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
        overlays = [ (import ./overlays) ];
      };
      stable-pkgs = import stable {
        inherit system;
        config.allowUnfree = true;
      };
      dirs = import ./config/directories.nix;
      packages = import ./config/packages.nix { inherit pkgs; };
      secrets = if builtins.pathExists (dirs.root + "/secrets.nix") then
        import ./secrets.nix
      else
        (lib.warn ''file "secrets.nix" is missing. Using file "templates/secrets.nix"''
          import templates/secrets.nix);

      inherit (secrets) users;
      user = users.primary;
      gtkTheme = {
        name = "Orchis-Dark";
        package = pkgs.orchis-theme.override {
          tweaks = [
            "black"
          ];
        };
      };
    in
      {
        nixosConfigurations = {
          Felix =
            let
              hostname = "Felix";
            in
              lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit
                   dirs
                   secrets
                   users
                   user
                   pkgs
                   stable-pkgs
                   inputs;
                };
                modules = with inputs; [
                  {
                    nixpkgs.hostPlatform = lib.mkDefault system;
                    networking.hostName = lib.mkDefault hostname;
                  }
                  impermanence.nixosModules.impermanence

                  disko.nixosModules.default
                  (import (dirs.felix + "/disko.nix" ){ device = "/dev/nvme0n1"; })

                  home-manager.nixosModules.home-manager
                  dirs.hosts
                  dirs.felix
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      extraSpecialArgs = {
                        inherit
                         dirs
                         packages
                         user
                         gtkTheme
                         pkgs
                         stable-pkgs
                         inputs;
                      };
                      users.${user.userName} = {
                        imports = [
                          impermanence.nixosModules.home-manager.impermanence
                          nixvim.homeManagerModules.nixvim
                          (dirs.felix + "/home.nix")
                        ];
                      };
                    };
                  }
                ];
              };

          Livia =
            let
              hostname = "Livia";
              user = users.secondary;
              gtkTheme = {
                name = "Adwaita";
              };
            in
              lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit
                   dirs
                   secrets
                   users
                   user
                   pkgs
                   stable-pkgs
                   inputs;
                };
                modules = with inputs; [
                  {
                    nixpkgs.hostPlatform = lib.mkDefault system;
                    networking.hostName = lib.mkDefault hostname;
                  }

                  disko.nixosModules.default
                  (import (dirs.livia + "/disko.nix") { device = "/dev/sda"; })

                  home-manager.nixosModules.home-manager
                  dirs.hosts
                  dirs.livia
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      extraSpecialArgs = {
                        inherit
                         dirs
                         packages
                         user
                         gtkTheme
                         pkgs
                         stable-pkgs
                         inputs;
                      };
                      users.${user.userName} = {
                        imports = [
                          nixvim.homeManagerModules.nixvim
                          (dirs.livia + "/home.nix")
                        ];
                      };
                    };
                  }
                ];
              };

          iso = let
            hostname = "ISO";
          in
            lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit
                 dirs
                 secrets
                 users
                 user
                 pkgs
                 stable-pkgs
                 inputs;
              };
              modules = with inputs; [
                dirs.hosts
                dirs.iso
                {
                  nixpkgs.hostPlatform = lib.mkDefault system;
                  networking.hostName = lib.mkDefault hostname;
                }
                (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                      inherit
                       dirs
                       gtkTheme
                       user
                       pkgs
                       stable-pkgs
                       inputs;
                    };
                    users.${user.userName} = {
                      imports = [
                        nixvim.homeManagerModules.nixvim
                        (dirs.iso + "/home.nix")
                      ];
                    };
                  };
                }
              ];
            };
        };
      };
}
