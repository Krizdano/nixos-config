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
      modules = import ./config/modules.nix;
      packages = import ./config/packages.nix { inherit pkgs; };
      secrets = if builtins.pathExists (modules.root + "/secrets.nix") then
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
                   packages
                   modules
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
                  (import (modules.felix + "/disko.nix" ){ device = "/dev/nvme0n1"; })

                  home-manager.nixosModules.home-manager
                  modules.hosts
                  modules.felix
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
                         stable-pkgs
                         inputs;
                      };
                      users.${user.userName} = {
                        imports = [
                          impermanence.nixosModules.home-manager.impermanence
                          nixvim.homeManagerModules.nixvim
                          (modules.felix + "/home.nix")
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
                   modules
                   packages
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
                  (import (modules.livia + "/disko.nix") { device = "/dev/sda"; })

                  home-manager.nixosModules.home-manager
                  modules.hosts
                  modules.livia
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
                         stable-pkgs
                         inputs;
                      };
                      users.${user.userName} = {
                        imports = [
                          nixvim.homeManagerModules.nixvim
                          (modules.livia + "/home.nix")
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
                 modules
                 packages
                 secrets
                 users
                 user
                 pkgs
                 stable-pkgs
                 inputs;
              };
              modules = with inputs; [
                modules.hosts
                modules.iso
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
                       modules
                       gtkTheme
                       user
                       pkgs
                       stable-pkgs
                       inputs;
                    };
                    users.${user.userName} = {
                      imports = [
                        nixvim.homeManagerModules.nixvim
                        (modules.iso + "/home.nix")
                      ];
                    };
                  };
                }
              ];
            };
        };
      };
}
