{myModules, ...}:
{
  imports = with myModules; [
    common
    greeters
  ];

  network = {
    enable = true;
    enablePrivateDNS = true;
    disableWpaSupplicant = true;
  };

  display.greeter = "greetd";
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
