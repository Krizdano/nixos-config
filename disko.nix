{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            label = "boot";
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "nixos";
              askPassword = true;
              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
                preLVM = true;
              };
              content = {
                type = "lvm_pv";
                vg = "vg0";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      vg0 = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "2G";
            content = {
            type = "swap";
            resumeDevice = true;
            };
          };
          system = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                };

                "/persist" = {
                  mountOptions = ["subvol=persist" "noatime" "compress=zstd"];
                  mountpoint = "/persist";
                };

                "/nix" = {
                  mountOptions = ["subvol=nix" "noatime" "compress=zstd"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/".neededForBoot = true;
    "/persist".neededForBoot = true;
    "/nix".neededForBoot = true;
  };
}
