{pkgs, username, users, lib, ... }:
{

  imports = [

  ];

  # adb
  programs.adb.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        inherit (users.root) hashedPassword;
      };
      ${username} = {
        inherit (users.primary) hashedPassword;
        isNormalUser = true;
        extraGroups = [ "jupyter" "networkmanager" "wheel" "video" "libvirtd" "audio" "adbusers" ];
        packages = with pkgs; [
          # user packages
        ];
      };
    };
  };

  services.flatpak.enable = true;

  #network settings
  networking = {
    hostName = "Felix-iso";
    wireless.enable = lib.mkForce false;
    networkmanager = {
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    useDHCP = false;
    wireless = {
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

  # bluetooth
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # only store 5 nixos generations
        configurationLimit = 5;
      };
      timeout = lib.mkDefault 0;
      # UEFI settings
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.useTmpfs = true;
    # kernelPackages = pkgs.linuxPackages_latest;  # get latest kernel
    kernel.sysctl = { "vm.swappiness" = 10; };
  };

  # control laptop screen brightness
  programs.light.enable = true;

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
