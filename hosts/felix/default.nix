{pkgs, username, users, ... }:
{
  imports = [
    ./rollback.nix
    ../../modules/programs/plymouth.nix
    ../persist.nix
  ];

  # adb
  programs.adb.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    extraConfig = "DNS=194.242.2.4 \n DNSOverTLS=opportunistic";
  };

  hardware = {
    enableRedistributableFirmware = true; # for loading wifi and gpu firmwares properly.
    amdgpu = {
      opencl = {
        enable = true;
      };
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
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
        extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "audio" "adbusers" ];
        packages = with pkgs; [
          # user packages
        ];
      };
    };
  };

  services.flatpak.enable = true;

  systemd.tmpfiles.rules = [
    "d /persist/home - ${username} users -"
  ];

  #network settings
  networking = {
    hostName = "Felix";
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

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # only store 5 nixos generations
        configurationLimit = 5;
      };
      timeout = 0;
      # UEFI settings
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;  # get latest kernel
    kernel.sysctl = { "vm.swappiness" = 10; };
  };

  #qemu and virt-manager
  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu.ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  # control laptop screen brightness
  programs.light.enable = true;
}
