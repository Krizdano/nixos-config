{ pkgs, gtkTheme, config, osConfig, dirs, ... }:
let
  inherit (config.xdg) configHome dataHome;
  emacs = ''${config.programs.emacs.package}/bin/emacs --batch --eval "(require 'org)" --eval'';
  gtk =
    let hostName = osConfig.networking.hostName;
    in
      {
        gtk-application-prefer-dark-theme = if hostName == "Livia" then false else true;
        color-scheme = if hostName == "Livia" then "prefer-light" else "prefer-dark";
      };
in
{
  imports = [ (dirs.services + "/systemd-services.nix") ]
            ++ (import ../programs)
            ++ (import ../shell);

  # fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      fg = "#cdd6f4";
      bg = "#1e1e2e";
      hl =  "#f38ba8";
      "fg+" = "#cdd6f4";
      "bg+" = "#313244";
      "hl+" = "#f38ba8";
      info = "#cba6f7";
      prompt = "#cba6f7";
      pointer = "#f5e0dc";
      marker = "#f5e0dc";
      spinner = "#f5e0dc";
      header = "#f38ba8";
    };
  };

  home = {
    file = {
      "${dataHome}/w3m/keymap".source = ../../config/w3m/keymap;
    };

    sessionVariables = {
      CARGO_HOME = "${dataHome}/cargo";
      ANDROID_USER_HOME = "${dataHome}/android";
      W3M_DIR = "${dataHome}/w3m";
      TERMINAL = "kitty";
      EDITOR = "emacsclient";
      VISUAL = "emacsclient";
      NIXOS_CONFIG = "${configHome}/nixconfig";
    };

    activation = {
      report-changes = config.lib.dag.entryAnywhere ''
            ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
            '';

      load-emacs-config = config.lib.dag.entryAfter ["writeBoundary"] ''
            ${emacs} '(org-babel-tangle-file
              "${dirs.root}/docs/emacs-config.org")'
            '';

      load-nyxt-config = config.lib.dag.entryAfter ["writeBoundary"] ''
            ${emacs} '(org-babel-tangle-file
              "${dirs.root}/docs/nyxt-config.org")'
            '';
    };
    stateVersion = "23.11";
  };


  #default home directories
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "firefox";
        "image/png" = "imv";
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      templates = null;
      publicShare = null;
      music = null;
      desktop = null;
      extraConfig = {
        XDG_OTHER_DIR = "${config.home.homeDirectory}/Other";
      };
    };
  };

  # themes
  gtk = {
    enable = true;
    gtk2.configLocation = "${configHome}/gtk-2.0/gtkrc";
    theme = gtkTheme;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 29;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "black"; };
    };
    gtk3.extraConfig = {
      inherit (gtk) gtk-application-prefer-dark-theme;
    };
    gtk4.extraConfig = {
      inherit (gtk) gtk-application-prefer-dark-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      inherit (gtk) color-scheme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
}
