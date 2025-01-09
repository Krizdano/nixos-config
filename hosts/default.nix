{ pkgs, inputs, myModules, packages, ... }:
let
  serviceModules = [
    /dbus.nix
    /pipewire.nix
    /openssh.nix
    /nix-daemon.nix
  ];
in
  {
    imports = [
      myModules.security
    ] ++ map (module: myModules.services + module) serviceModules;

    # Enable flakes
    nix = {
      nixPath = [
        "nixpkgs=${inputs.nixpkgs}"
      ];
      channel.enable = false;
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        use-xdg-base-directories = true;
        trusted-users = [ "@wheel" ];
      };
      registry.nixpkgs.flake = inputs.nixpkgs;
    };

    time.timeZone = "Asia/Kolkata";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
      options = "caps:backspace,shift:both_capslock";
    };

    #tty
    console = {
      useXkbConfig = true;
    };

    services.flatpak.enable = true;

    programs = {
      # dconf (for gtk apps to work properly)
      dconf = {
        enable = true;
      };
      git.enable = true;
      zsh.enable = true;
      nano = {
        enable = false; # remove nano
      };
    };

    environment = {
      systemPackages = with pkgs; [
        wget
        ed
      ];
      defaultPackages = with pkgs; [ ed ]; # Remove default packages
      pathsToLink = [ "/share/zsh" ];
      shells = with pkgs; [ zsh ];
      variables = {
        NIX_REMOTE = "daemon"; # Force nix command to call the daemon
        NIXOS_OZONE_WL = 1;
      };
    };

    programs.bash = {
      completion = {
        enable = true;
      };
      enableLsColors = true;
      promptInit = ''eval "$(starship init bash)"'';
    };

    fonts = {
      fontconfig.enable = true;
      packages = with packages.fonts; [
        main.package
        forWaybar.package
        forHyprlock.package
      ];
    };

    #xdg
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config = {
          common = {
            default = [ "gtk" ];
          };
        };
      };
    };

    # Open ports in the firewall.
    networking.firewall = {
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # kdconnect
      ];

      allowedUDPPortRanges = [
        { from = 1741; to = 1764; } # kdeconnect
      ];

      allowedTCPPorts = [ ];
    };

    system.stateVersion = "24.11";
  }
