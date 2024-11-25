{ pkgs, config, ... }: {

  imports = [
    ../../modules/home/default.nix
    ../../modules/windowmanagers/niri/default.nix
  ]
  ++ (import ../../modules/services);

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
