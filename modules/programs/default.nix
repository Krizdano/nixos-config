{myModules, ...}:
let
  browserList = [
    /firefox
    /chromium.nix
    /qute.nix
    /nyxt.nix
  ];
  terminalList = [
    /kitty.nix
    /alacritty.nix
    /wezterm.nix
  ];
in
  {
    imports = with myModules; [
      ./gh.nix
      ./git.nix
      ./lf.nix
      ./mpv.nix
      ./htop.nix
      ./starship.nix
      ./waybar.nix
      ./direnv.nix
      ./emacs.nix
      ./pistol.nix
      #./atuin.nix
      #./plymouth
      ./zellij.nix
      ./nixvim.nix
      ./aria2.nix
    ] ++ map (terminal: terminals + terminal) terminalList
      ++ map (browser: browsers + browser) browserList;
 }
