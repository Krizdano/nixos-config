{modules, ...}: {
  imports = with modules; [
    (programs + /plymouth.nix)
    common
    desktopManagers
    greeters
  ] ++ import hardware;

  graphics.enable = true;
  network.enable = true;
  display = {
    desktopManagers = ["gnome"];
    greeter = "gdm";
  };
  boot.disableBuiltinKeyboard = true;
}
