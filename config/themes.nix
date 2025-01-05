{pkgs, ...}: {
  orchis = {
    name = "Orchis-Dark";
    package = pkgs.orchis-theme.override {
      tweaks = [
        "black"
      ];
    };
  };
  adwaita = {
    name = "Adwaita";
  };
}
