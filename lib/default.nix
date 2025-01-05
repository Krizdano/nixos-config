{args}:
let
  inherit (args) myModules inputs users;
in
 {
  mkNixosConfig = {
    system ? "x86_64-linux",
    hostname,
    user ? users.primary,
    themeForGtk ? "orchis",
    diskoDevice,
    extraModules ? []
  }:
    let
      inherit (inputs.nixpkgs) lib;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import (myModules.root + /overlays) { inherit (inputs) stable; inherit system; }) ];
      };
      packages = import myModules.packages { inherit pkgs; };
      themes = import (myModules.config + /themes.nix) {inherit pkgs;};
      gtkTheme = themes.${themeForGtk};
    in
      lib.nixosSystem
        {
          inherit system;
          specialArgs =  args // { inherit user pkgs packages; };
          modules = with inputs; [
            {
              nixpkgs.hostPlatform = lib.mkDefault system;
              networking.hostName = lib.mkDefault hostname;
            }
            impermanence.nixosModules.impermanence
            disko.nixosModules.default
            (if diskoDevice != null then
              ({config, ...}: {
                imports = [
                  (import myModules.disko {
                    inherit lib config;
                    device = diskoDevice;
                  })
                ];
              })
            else {})

            home-manager.nixosModules.home-manager
            myModules.hosts
            myModules.${hostname}
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = args // { inherit user gtkTheme pkgs packages; };
                users.${user.userName} = {
                  imports = [
                    impermanence.nixosModules.home-manager.impermanence
                    nixvim.homeManagerModules.nixvim
                    (myModules.${hostname} + "/home.nix")
                  ];
                };
              };
            }
          ] ++ extraModules;
        };
 }
