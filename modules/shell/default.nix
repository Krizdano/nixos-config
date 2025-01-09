{lib, myModules, pkgs, ...}:
let
  shellAliases = {
    common = {
      ll = "ls -l";
      gg = "w3m google.com"; # w3m with google
      search = "nix search nixpkgs";
      connect = "kdeconnect-cli";
      cat = "${pkgs.bat}/bin/bat";
      cp = "cp -v";
      mv = "mv -v";
    };
    zsh = {
      ls = "ls --color=always";
      update = "pushd $NIXOS_CONFIG; nix flake update; popd";
      notes = ''glow  $NIXOS_CONFIG/notes'';
      re = "pushd $NIXOS_CONFIG; ${pkgs.nh}/bin/nh os switch --ask path:.; popd"; # nixos rebuild
    } // shellAliases.common;
    nushell = {
      # update = "pushd $env.NIXOS_CONFIG; nix flake update; popd"; // TODO: no pushd on nushell need to find alternative
      # re = "pushd $NIXOS_CONFIG; sudo nixos-rebuild switch --flake path:.#$(hostname); popd"; # nixos rebuild // TODO: no pushd on nushell need to find alternative
    } // shellAliases.common;
    fish = shellAliases.common // shellAliases.zsh;
  };
  shells = [
    /zsh.nix
    /fish.nix
    /nushell.nix
  ];
in
  {
    imports =  map (shell: import (myModules.shells + shell) { inherit shellAliases;}) shells;

    options.shells.list = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "list of shells installed";
    };
  }
