{config, lib, user, ...}:
 let
   dirs = {
     var = {
       root = "/var/";
       dirs = [
         "log"
         "cache"
       ];
     };
     lib = {
       root = dirs.var.root + "lib/";
       dirs = [
         "libvirt"
         "iwd"
         "bluetooth"
         "nixos"
         "systemd"
         "NetworkManager"
         "flatpak"
         "machines"
       ];
     };
   };
 in {
   imports = [ ./home.nix ./rollback.nix ];
   options.persist = {
     enable = lib.mkOption {
       type = lib.types.bool;
       default = false;
     };
   };
   config = lib.mkIf config.persist.enable {
     programs.fuse.userAllowOther = true;
     environment.persistence."/persist" = {
       hideMounts = true;
       directories = [
         "/etc/nixos"
         "/root/.cache/nix"
       ] ++ map (dir: dirs.var.root + dir) dirs.var.dirs
       ++ map (dir: dirs.lib.root + dir) dirs.lib.dirs;

       files = [
         "/etc/machine-id"
       ];
     };

     systemd.tmpfiles.rules = [
       "d /persist/home - ${user.userName} users -"
     ];

     # The service systemd-machine-id-commit.service will now cause problems
     # if /etc/machine-id is configured as a bind mount. It may work if it is a symlink.
     # Merged PR: https://github.com/NixOS/nixpkgs/pull/351151
     # Issue: https://github.com/nix-community/impermanence/issues/229
     boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
     systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
   };
 }
