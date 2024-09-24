{ pkgs, ... }: {
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];
    };
    avahi = {
      enable = true;
      openFirewall = true;
    };
  };
}
