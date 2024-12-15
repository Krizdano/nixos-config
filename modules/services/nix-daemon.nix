_:{
  # move nix daemon from ram to disk
  systemd.services.nix-daemon = {
    environment = {
      #location for temporary files
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # create /var/cache/nix automatically on nix deamon start
      CacheDirectory = "nix";
    };
  };
}
