{modules, packages,  ...}: {
  imports = with modules; [
    display
    home
  ];

  home.packages = packages.felix;

  display = {
    wms = [
      "hyprland"
      "niri"
    ];
    menu = "fuzzel";
    lockscreen = "hyprlock";
    idle-daemon = "hypridle";
    notifications = "dunst";
  };

  browsers = {
    firefox = {
      enable = true;
      hardened = true;
    };
    nyxt = true;
  };

  services = {
    sortfiles = true;
    batlevel = true;
    chpaper = true;
  };

  shells.list = ["nushell" "fish"];
}
