{packages, modules, config, ...}: {

  imports = with modules; [
    home
  ] ++ (import services);

  browsers.firefox = {
    enable = true;
    hardened = true;
  };

  display = {
    wms = ["niri"];
    menu = "fuzzel";
    lockscreen = "hyprlock";
    idle-daemon = "hypridle";
    notifications = "dunst";
  };

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
