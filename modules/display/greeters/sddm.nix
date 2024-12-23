{lib, config, ...}: {
  config = lib.mkIf (config.display.greeter == "sddm") {
    services.displayManager = {
      defaultSession = "plasma";
      sddm = {
        wayland.enable = true;
        enable = true;
      };
    };
  };
}
