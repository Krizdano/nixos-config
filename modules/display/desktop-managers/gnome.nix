{pkgs, user, lib, config, ...}:
let
  gnomeExtensions =  with pkgs.gnomeExtensions; [
    dash-to-dock
    blur-my-shell
    caffeine
  ];
in
  {
    config = lib.mkIf (builtins.elem "gnome" config.display.desktopManagers) {
      services.xserver = {
        desktopManager.gnome = {
          enable = true;
        };
      };
      environment = {
        systemPackages = gnomeExtensions;
        gnome = {
          excludePackages = with pkgs; [
            cheese # webcam tool
            seahorse
            gnome-music
            gnome-terminal
            epiphany # web browser
            geary # email reader
            evince # document viewer
            gnome-characters
            gnome-software
            gnome-tour
            totem # video player
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game
          ];
        };
      };

      home-manager.users.${user.userName}.dconf = {
        settings."org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions =  map (extension: extension.extensionUuid) gnomeExtensions;
        };
      };
    };
  }
