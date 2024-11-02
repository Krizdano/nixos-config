_: {
  programs.fuse.userAllowOther = true;
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/lib/libvirt"
      "/var/lib/iwd"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/NetworkManager"
      "/var/lib/flatpak"
      "/var/lib/machines"
      "/var/log"
      "/var/cache"
      "/root/.cache/nix"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  # The service systemd-machine-id-commit.service will now cause problems
  # if /etc/machine-id is configured as a bind mount. It may work if it is a symlink.
  # Merged PR: https://github.com/NixOS/nixpkgs/pull/351151
  # Issue: https://github.com/nix-community/impermanence/issues/229
  boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
