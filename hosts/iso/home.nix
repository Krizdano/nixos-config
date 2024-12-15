{ pkgs, dirs, config, ... }: {

  imports = [
    (dirs.home + "/default.nix")
    (dirs.wms + "/niri/default.nix")
  ] ++ (import dirs.services);

  home = {
    packages = with pkgs; [
      toki
      keepassxc
      plymouth
      nitch
      unzip
      gdu # disk management
      scripts # my scripts
      jmtpfs
      imv
    ];
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
