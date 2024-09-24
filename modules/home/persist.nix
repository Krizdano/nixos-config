{ config, lib, ...}: {
  home.persistence."/persist/home/" = {
    allowOther = true;
    directories = [
      ".mozilla"
      ".ssh"

      { directory = ".config/epr"; method = "symlink"; }
      { directory = ".config/lobster"; method = "symlink"; }
      { directory = ".config/kdeconnect"; method = "symlink"; }
      { directory = ".config/Signal"; method = "symlink"; }
      { directory = ".config/keepassxc"; method = "symlink"; }
      { directory = ".config/epr"; method = "symlink"; }
      { directory = ".config/emacs"; method = "symlink"; }
      { directory = ".config/nyxt"; method = "symlink"; }
      { directory = ".config/nixconfig"; method = "symlink"; }

      # for android studio
      # ".config/.android"
      # ".config/Android Open Source Project"
      # ".config/Google"
      # ".m2"
      # ".local/share/Android Open Source Project"
      # ".local/share/Google"
      # ".local/share/kotlin"
      # "Android"
      # "AndroidStudioProjects"

      { directory = ".cache/mesa_shader_cache"; method = "symlink"; }
      { directory = ".cache/mozilla"; method = "symlink"; }
      { directory = ".cache/nix"; method = "symlink"; }
      { directory = ".cache/nvim"; method = "symlink"; }

      # ".config/emacs"
      ".local/share/gnupg"
      ".local/share/flatpak"
      ".local/share/direnv"
      ".local/share/android"
      ".local/share/w3m"
      ".local/share/emacs-backup"
      ".local/state/wireplumber"

      { directory = ".local/share/TelegramDesktop"; method = "symlink"; }
      { directory = ".local/share/zsh"; method = "symlink"; }

      { directory = "Downloads"; method = "symlink"; }
      { directory = "Documents"; method = "symlink"; }
      { directory = "Videos"; method = "symlink"; }
      { directory = "Pictures"; method = "symlink"; }
      { directory = "Other"; method = "symlink"; }
      { directory = "projects"; method = "symlink"; }
    ];

    files = [
      ".config/gh/hosts.yml"
    ];
  };

  # There is a small bug in impermanence module
  # Symlinks created via the home-manager module are broken
  # while the symlinks points to the correct location, this location is never created
  # So this is a temporary fix
  # issue: https://github.com/nix-community/impermanence/issues/177
  home.activation.createTargetFileDirectoriesFixup =
    let
      isSymlink = entry: (!lib.isString entry) && (entry.method == "symlink");
      entryPath = entry: if lib.isString entry then entry else entry.directory;

      cfg = config.home.persistence;

      persistenceRoots = lib.attrNames cfg;
      mkdirPersistentLocations = map (root:
        let
          persistentDirectories =
            # Collect all directories which are symlinks
            (map entryPath (lib.filter isSymlink cfg.${root}.directories)) ++
            # And all directories of files
            (map dirOf (map entryPath cfg.${root}.files));

          completePaths = map (path: lib.path.append (/. + root) path) persistentDirectories;
          mkdirCommands = lib.concatMapStrings (completePath: "run mkdir -p ${lib.escapeShellArg completePath}\n") completePaths;
        in ''
        # mkdir's for ${root}

        ${mkdirCommands}
      ''
      ) persistenceRoots;
    in
      config.lib.dag.entryBetween [ "writeBoundary" ] [ "createTargetFileDirectories" ] (
        lib.concatMapStrings (cmds: "${cmds}\n") mkdirPersistentLocations
      );
}

