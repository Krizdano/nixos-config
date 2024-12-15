{ packages, dirs, config, ... }: {

  imports = [
    (dirs.home + "/default.nix")
    (dirs.wms + "/niri/default.nix")
  ] ++ (import dirs.services);

  home = {
    packages = packages.iso;
    file."${config.xdg.configHome}/nixconfig".source = ../..;
    activation = {
      make-emacs-directory = config.lib.dag.entryBefore ["load-emacs-config"] ''
                   mkdir ${config.xdg.configHome}/emacs
            '';

      make-nyxt-directory = config.lib.dag.entryBefore ["load-nyxt-config"] ''
                   mkdir ${config.xdg.configHome}/nyxt
            '';
    };
  };
}
