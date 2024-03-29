# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  nixpkgs,
  system,
  user,
  ...
}: let
  yazi = pkgs.symlinkJoin {
    name = "yazi-wrapped";
    paths = [pkgs.yazi];
    nativeBuildInputs = [pkgs.makeBinaryWrapper];
    postBuild = ''
      wrapProgram "$out/bin/yazi" --set TERM_PROGRAM "WezTerm"
    '';
  };

  pkgs = import nixpkgs {
    config.allowUnfree = true;
    system = "${system}";
    overlays = [
      (import ../../../overlay/overlay.nix)
    ];
  };

  reverse_proxy_string = (import ../mini/caddy-helpers.nix).reverse_proxy_string;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # networking.firewall.allowedTCPPorts = [ 6443 ]; # 6443 k3s
  # services.k3s.enable = false;
  # services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
  # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelParams = [
    "cgroup_enable=cpuset"
    "cgroup_memory=1"
    "cgroup_enable=memory"
    "cma=128M"
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      silverbullet = {
        ports = ["127.0.0.1:3000:3000"];
        image = "gitea.c4er.com/matt/silverbullet:0.6.1";
        # command = [ "/bin/sh" ];
        # args = [ "-c" "echo 'Hello, world!'" ];
        volumes = [
          "/home/${user}/SyncWork/Notes/Notes:/space"
        ];
        # restartPolicy = "always";
      };
      pihole = {
        ports = [
          "192.168.10.10:53:53/tcp"
          "192.168.10.10:53:53/udp"
          "127.0.0.1:3080:80"
          "127.0.0.1:30443:443"
        ];
        image = "pihole/pihole:latest";
        volumes = [
          "/var/lib/pihole/:/etc/pihole/"
          "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
        ];
        environment = {
          ServerIP = "192.168.10.10";
        };
        extraOptions = [
          "--cap-add=NET_ADMIN"
          "--dns=127.0.0.1"
          "--dns=1.1.1.1"
        ];
        workdir = "/var/lib/pihole/";
      };
    };
  };

  # Select internationalisation properties.
  #    i18n.defaultLocale = "en_US.UTF-8";
  #    console = {
  #      font = "Lat2-Terminus16";
  ##      keyMap = "us";
  #
  #      useXkbConfig = true; # use xkbOptions in tty.
  #    };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services = {
    syncthing = {
      enable = true;
      user = user;
      dataDir = "/mnt/syncthing/personal";
      configDir = "/mnt/syncthing/config";
    };
  };

  systemd.services.nebula = {
    enable = true;
    description = "nebula";
    serviceConfig = {
      ExecStart = "${pkgs.nebula}/bin/nebula -config /etc/nebula/config.yaml";
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.${user} = {
  #   shell = pkgs.fish;
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     fish
  #     firefox
  #     thunderbird
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    # git
    # helix
    # zsh
    # fish
    # k3s
    nebula
    caddy
    docker
    docker-compose
    syncthing
    yazi
  ];
  # environment.shells = with pkgs; [ zsh fish ];

  services.caddy = {
    enable = true;

    virtualHosts."pihole.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      ${reverse_proxy_string 3080}
    '';

    virtualHosts."notez.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      ${reverse_proxy_string 3071}
    '';

    virtualHosts."notey.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      ${reverse_proxy_string 3000}
    '';

    virtualHosts."excalidraw.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      handle_path /* {
        reverse_proxy https://excalidraw.c4er.com {
          transport http {
            tls
            tls_server_name excalidraw.c4er.com
          }
        }
      }
    '';

    virtualHosts."note.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      handle_path /* {
        reverse_proxy https://silverbullet.c4er.com {
          header_up Host silverbullet.c4er.com
          transport http {
            tls
            tls_server_name silverbullet.c4er.com
          }
        }
      }
    '';

    # uri strip_prefix /path hides this portion of the path from the upstream

    # header_up Host <domain> tells the origin what domain should be displayed
    # failure to do this will be the same as showing example.com instead of sub.example.com

    virtualHosts."proxy.c4er.com".extraConfig = ''
      tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key

      handle_path /excalidraw/* {
        uri strip_prefix /excalidraw
        reverse_proxy https://excalidraw.c4er.com {
          header_up Host excalidraw.c4er.com
          transport http {
            tls
            tls_server_name excalidraw.c4er.com
          }
        }
      }
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # programs.fish.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking = {
    hostName = "dockingbay94"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    # time.timeZone = "America/Los_Angeles";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    extraHosts = ''
      127.0.0.2 other-localhost
    '';

    # Disable ipv6
    enableIPv6 = false;
    # Open ports in the firewall.
    firewall.allowedTCPPorts = [
      53 # DNS
      443
      8384 # syncthing
      22000 #syncthing
    ];

    firewall.allowedUDPPorts = [
      22000 #syncthing
      21027 #syncthing
      53 # DNS Pihole
    ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
