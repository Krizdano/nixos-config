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
      sourceDir = ./.;
      secrets = if builtins.pathExists ("${sourceDir}" + "/secrets.nix")
                then import ./secrets.nix
                else import templates/secrets.nix;
      inherit (secrets) users;
      username = users.primary.userName;
    in
      {
        nixosConfigurations = {
          Felix = lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit sourceDir;
              inherit secrets;
              inherit users;
              inherit username;
              inherit pkgs;
              inherit stable-pkgs;
              inherit inputs;
            };
            modules = with inputs; [
              {
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              impermanence.nixosModules.impermanence

              disko.nixosModules.default
              (import ./disko.nix { device = "/dev/nvme0n1"; })

              home-manager.nixosModules.home-manager
              ./hosts
              ./hosts/felix
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit sourceDir;
                    inherit secrets;
                    inherit users;
                    inherit username;
                    inherit pkgs;
                    inherit stable-pkgs;
                    inherit inputs;
                  };
                  users.${username} = {
                    imports = [
                      impermanence.nixosModules.home-manager.impermanence
                      nixvim.homeManagerModules.nixvim
                      ./hosts/felix/home.nix
                    ];
                  };
                };
              }
            ];
          };

          iso = lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit sourceDir;
              inherit secrets;
              inherit users;
              inherit username;
              inherit pkgs;
              inherit stable-pkgs;
              inherit inputs;
            };
            modules = with inputs; [
              ./hosts
              ./hosts/iso
              {
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit sourceDir;
                    inherit secrets;
                    inherit users;
                    inherit username;
                    inherit pkgs;
                    inherit stable-pkgs;
                    inherit inputs;
                  };
                  users.${username} = {
                    imports = [
                      nixvim.homeManagerModules.nixvim
                      ./hosts/iso/home.nix
                    ];
                  };
                };
              }
            ];
          };
        };
      };
}
