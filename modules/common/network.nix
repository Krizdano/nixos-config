{lib, config, ...}: {
  options.network = with lib; with lib.types; {
    enable = mkOption {
      type = bool;
      default = false;
    };
    enablePrivateDNS = mkOption {
      type = bool;
      default = false;
    };
    disableWpaSupplicant = mkOption {
      type = bool;
      default = false;
    };
  };
  config = let cfg = config.network; in {
    networking = lib.mkIf cfg.enable {
      networkmanager = {
        dns = lib.mkIf cfg.enablePrivateDNS "systemd-resolved";
        enable = true;
        wifi = {
          backend = "iwd";
          powersave = false;
        };
      };
      useDHCP = false;
      wireless = {
        enable = lib.mkIf cfg.disableWpaSupplicant (lib.mkForce false);
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
    services.resolved = lib.mkIf cfg.enablePrivateDNS {
      enable = true;
      dnssec = "false";
      domains = [ "~." ];
      extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";
    };
  };
}
