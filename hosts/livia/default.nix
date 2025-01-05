{myModules, ...}: {
  imports = with myModules; [
    plymouth
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
