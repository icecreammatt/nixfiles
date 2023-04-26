# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  services.vaultwarden.enable = true;
  services.k3s.enable = false;
  services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  services.caddy = {
    enable = true;

    extraConfig = ''
        :80 {
          encode gzip
          file_server

          handle_path /* {
            root * "/mnt/storage/webroot"
            file_server browse
          }
        }
    '';

    virtualHosts."mini.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."mini-story.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:6006
        }
    '';

    virtualHosts."mini-vpn.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."bw-vpn.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8000
        }
    '';

    virtualHosts."pocketbase.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8090
        }
    '';
    
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device= "nodev";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mini"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  # time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     k3s
     nebula
     morph
     tmux
     caddy
     nodejs
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    6443 # k3s?
    8090
    443
    80
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

