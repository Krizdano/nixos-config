{ pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: with epkgs; [
      vterm
      evil
      evil-collection
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
      treemacs
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
    ];
  };

  home.packages = with pkgs; [
    rust-analyzer
    clang-tools
    clang
    nil
    zls
    cargo
    rustc
    python3 # for treemacs
    python312Packages.python-lsp-server
  ];

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };
}
