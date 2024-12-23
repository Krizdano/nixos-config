{lib, config, ...}:{
  options.network = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    enablePrivateDNS = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = {
    networking = lib.mkIf (config.network.enable) {
      networkmanager = {
        dns = lib.mkIf (config.network.enablePrivateDNS) "systemd-resolved";
        enable = true;
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
    services.resolved = lib.mkIf (config.network.enablePrivateDNS) {
      enable = true;
      dnssec = "false";
      domains = [ "~." ];
      extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";
    };
  };
}
