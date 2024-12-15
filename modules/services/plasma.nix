{pkgs, ...}: {
  services = {
    xserver.enable = true;
    desktopManager.plasma6 = {
      enable = true;
    };
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        wayland.enable = true;
        enable = true;
      };
    };
  };
}
