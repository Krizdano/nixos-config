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
}
