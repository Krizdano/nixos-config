_: {
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
}
