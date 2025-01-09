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
    desktopManagers = ["plasma"];
    greeter = "sddm";
  };
  boot.disableBuiltinKeyboard = true;
}
