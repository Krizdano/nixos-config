{ pkgs, ... }: {
  boot = {
    consoleLogLevel = 3;
    initrd.systemd.enable = true;
    kernelParams = [ "quiet" ];
    plymouth = {
      enable = true;
      themePackages = [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "sphere" ]; })
      ];
      theme = "sphere";
    };
  };
}
