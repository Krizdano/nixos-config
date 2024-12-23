{lib, config, ...}: {
  config = lib.mkIf (config.display.greeter == "gdm") {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
