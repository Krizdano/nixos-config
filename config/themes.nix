{pkgs, ...}: {
  name = "Orchis-Dark";
  package = pkgs.orchis-theme.override {
    tweaks = [
      "black"
    ];
  };
}
