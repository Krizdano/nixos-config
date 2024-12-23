{modules, packages, ...}: {
  imports = with modules; [
    home
  ] ++ (import services);

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
