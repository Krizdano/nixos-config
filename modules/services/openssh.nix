{ lib, ... }: {
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = lib.mkDefault "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/keys/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/keys/ssh_host_rsa_key";
        type = "rsa";
        bits = "4096";
      }
    ];
  };
}
