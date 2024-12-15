{ dirs, packages, ... }: {
  imports = [
    (dirs.home + "/default.nix")
  ] ++ (import dirs.services);

  home.packages = packages.livia;
}
