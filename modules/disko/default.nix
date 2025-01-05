{
  lib,
  config,
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}:
   {
     options.disks.setupEncryptedBtrfs = lib.mkOption {
       type = lib.types.bool;
       default = false;
     };
     config = let
       cfg = config.disks.setupEncryptedBtrfs;
       isCfg = lib.mkIf cfg;
       notCfg = lib.mkIf (!cfg);
     in
       {
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
                       "umask=0077"
                     ];
                   };
                 };
                 root = notCfg {
                   size = "100%";
                   content = {
                     type = "btrfs";
                     extraArgs = [ "-f" ]; # Override existing partition
                     mountpoint = "/";
                     mountOptions = [ "compress=zstd" "noatime" ];
                   };
                 };
                 luks = isCfg {
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
           lvm_vg = isCfg {
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

         fileSystems = isCfg {
           "/".neededForBoot = true;
           "/persist".neededForBoot = true;
           "/nix".neededForBoot = true;
         };
       };
   }
