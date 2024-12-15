_:{
  #network settings
  networking = {
    networkmanager = {
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    useDHCP = false;
    wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            AddressRandomization = "network";
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
  };
}
