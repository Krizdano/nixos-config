_: {
  # enable doas
  security = {
    doas = {
      enable = true;
      # Configure doas
      extraRules = [{
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false; # disable sudo
  };
}
