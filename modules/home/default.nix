{ pkgs, config, myModules, ... }:
let
  inherit (config.xdg) configHome dataHome;
  emacs = ''${config.programs.emacs.package}/bin/emacs --batch --eval "(require 'org)" --eval'';
in
{
  imports = with myModules; [
    programs
    ../shell
    ./gtk.nix
   ] ++ (import services);

  terminals.alacritty = true;

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
      load-emacs-config = config.lib.dag.entryAfter ["writeBoundary"] ''
            ${emacs} '(org-babel-tangle-file
              "${myModules.root}/docs/emacs-config.org")'
            '';
    };
    stateVersion = "24.11";
  };


  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "firefox";
        "image/png" = "imv";
      };
    };
    # Default home directories
    userDirs = {
      enable = true;
      createDirectories = true;
      templates = null;
      publicShare = null;
      desktop = null;
      extraConfig = {
        XDG_OTHER_DIR = "${config.home.homeDirectory}/Other";
      };
    };
  };
}
