_:{
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";
  };
  networking.networkmanager.dns = "systemd-resolved";
}
