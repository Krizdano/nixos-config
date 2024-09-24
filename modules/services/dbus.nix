{ pkgs, ... }: {
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ]; # for graphical authorisation
  };
}
