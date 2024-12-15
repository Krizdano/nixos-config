_: {
  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults lecture="never"
      '';
      wheelNeedsPassword = true;
    };
  };
}
