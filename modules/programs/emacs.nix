{ pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: with epkgs; [
      nerd-icons-dired
      vterm
      sml-mode
      xclip
      emms
      evil
      evil-collection
      evil-terminal-cursor-changer
      general
      drag-stuff
      undo-tree
      rainbow-mode
      rainbow-delimiters
      eat
      direnv
      perspective
      pdf-tools
      tldr
      toc-org
      sideline
      sideline-flymake
      sideline-blame
      evil-mc
      sly
      popper
      catppuccin-theme
      doom-themes
      doom-modeline
      dired-open
      org-auto-tangle
      org-modern
      nix-ts-mode
      markdown-mode
      lua-mode
      company
      company-box
      eldoc-box
      multi-vterm
      smex
      indent-bars
      nerd-icons
      ledger-mode
    ];
  };

  home.packages = with pkgs; [
    rust-analyzer
    clang-tools
    clang
    nil
    zls
    cargo
    ledger
    rustc
    python3 # for treemacs
    python312Packages.python-lsp-server
  ];

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };
  systemd.user.services.emacs.Service.Environment = [
    "COLORTERM=truecolor"
    "TERM=xterm-256color"
  ];
}
