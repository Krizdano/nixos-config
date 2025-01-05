{myModules, packages, ...}: {
  imports = with myModules; [
    home
  ];

  home.packages = packages.livia;
  browsers.firefox = {
    enable = true;
    enableAdBlock = true;
    enableVimSupport = true;
    enableContainers = true;
    enableBitWarden = true;
  };
  services.sortfiles = true;
  gtk.enableDarkMode = false;
}
