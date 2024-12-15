{ config, lib, ...}:
let
  method = "symlink";
  dirs = {
    config = {
      root = ".config/";
      dirs.symLink = [
        "epr"
        "lobster"
        "kdeconnect"
        "Signal"
        "keepassxc"
        "emacs"
        "nyxt"
        "nixconfig"
      ];
    };
    home = {
      dirs.symLink = [
        "Downloads"
        "Documents"
        "Videos"
        "Pictures"
        "Other"
        "projects"
      ];
    };
    cache = {
      root = ".cache/";
      dirs.symLink = [
        "mesa_shader_cache"
        "mozilla"
        "nix"
        "nvim"
      ];
    };
    share = {
      root = ".local/share/";
      dirs = {
        symLink = [
          "TelegramDesktop"
          "zsh"
        ];
        noSymLink = [
          "gnupg"
          "flatpak"
          "direnv"
          "android"
          "w3m"
          "emacs-backup"
          "wireplumber"
        ];
      };
    };
    # for android studio
    androidStudio = {
      dirs = [
      ".config/.android"
      ".config/Android Open Source Project"
      ".config/Google"
      ".m2"
      ".local/share/Android Open Source Project"
      ".local/share/Google"
      ".local/share/kotlin"
      "Android"
      "AndroidStudioProjects"
      ];
    };
  };
in
{
  home.persistence."/persist/home/" = {
    allowOther = true;
    directories = [
      ".mozilla"
      ".ssh"
    ] # ++ dirs.androidStudio.dirs
      ++ map (dir: dirs.share.root + dir) dirs.share.dirs.noSymLink
      ++ map (dir: {directory = dirs.share.root + dir; inherit method;}) dirs.share.dirs.symLink
      ++ map (dir: {directory = dirs.config.root + dir; inherit method;}) dirs.config.dirs.symLink
      ++ map (dir: {directory = dir; inherit method;}) dirs.home.dirs.symLink
      ++ map (dir: {directory = dirs.cache.root +  dir; inherit method;}) dirs.cache.dirs.symLink;

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

