# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./caddy.nix
    ];

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "matt" ];
  users.users.matt.extraGroups = [ "docker" ];


  virtualisation.vmVariant = {
    # nixos-rebuild build-vm --flake .#mini
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
    virtualisation.forwardPorts = [
        { from = "host"; host.port = 8888; guest.port = 80; }
        { from = "host"; host.port = 2121; guest.port = 22; }
    ];
  };

  services.grafana = {
    enable = true;
    domain = "grafana.c4er.com";
    port = 2342;
    addr = "127.0.0.1";
  };

  services.prometheus = {
    enable = true;
    port = 9001;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };

    scrapeConfigs = [
      {
        job_name = "mini";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };

  systemd.services.nebula = {
    enable = true;
    description = "nebula";
    serviceConfig = {
      ExecStart = "${pkgs.nebula}/bin/nebula -config /etc/nebula/config.yaml";
      Type = "simple";
      Restart = "always";
      RestartSec=1;
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.rewind-db = {
    enable = true;
    description = "rewind-db";
    serviceConfig = {
      ExecStart = "/home/matt/pocketbase/pocketbase serve";
      Type = "simple";
      Restart = "always";
      RestartSec=1;
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.vaultwarden.enable = true;
  services.vaultwarden.config = {
    ROCKET_ADDRESS = "127.0.0.1";
    ROCKET_PORT = 8110;
  };

  services.k3s.enable = false;
  services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  services.hydra = {
    enable = true;
    port = 3050;
    notificationSender = "hydra@localhost"; # e-mail of hydra service
    hydraURL = "http://localhost:3050";
    # buildMachinesFiles = [];
    useSubstitutes = true;
  };

  nix.buildMachines = [
    { 
      hostName = "localhost";
      system = "x86_64-linux";
      supportedFeatures = [];
      maxJobs = 8;
    }
  ];

  services.woodpecker-server = {
    enable = true;
    environment = {
      WOODPECKER_HOST = "https://woodpecker.c4er.com";
      WOODPECKER_SERVER_ADDR = ":3007";
      WOODPECKER_OPEN = "true";

      WOODPECKER_ADMINS="Matt";
      WOODPECKER_ADMIN="Matt";
      WOODPECKER_GITEA="true";
      WOODPECKER_GITEA_URL="https://gitea.c4er.com";
    };
    # You can pass a file with env vars to the system it could look like:
    # WOODPECKER_AGENT_SECRET=XXXXXXXXXXXXXXXXXXXXXX
    environmentFile = config.sops.secrets."woodpecker/WOODPECKER_AGENT_SECRET".path; # "/path/to/my/secrets/file";
  };

    # This sets up a woodpecker agent
  services.woodpecker-agents.agents."docker" = {
    enable = true;
    # We need this to talk to the podman socket
    extraGroups = [ "docker" ];
    environment = {
      WOODPECKER_SERVER = "localhost:9000";
      WOODPECKER_MAX_WORKFLOWS = "4";
      DOCKER_HOST = "unix:///run/docker.sock";
      WOODPECKER_BACKEND = "docker";
    };
    # Same as with woodpecker-server
    # environmentFile = [ "/var/lib/secrets/woodpecker.env" ];
    environmentFile = [config.sops.secrets."woodpecker/WOODPECKER_AGENT_SECRET".path]; # "/path/to/my/secrets/file";
  };

  sops.secrets."woodpecker/WOODPECKER_AGENT_SECRET" = {
    sopsFile = ../../../.secrets/woodpecker.ini;
    # owner = config.services.woodpecker-server.user;
    format = "ini";
  };

  sops.secrets."postgres/gitea_dbpass" = {
    sopsFile = ../../../.secrets/postgres.yaml;
    owner = config.services.gitea.user;
  };

  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/matt/.config/sops/age/keys.txt";

  services.gitea = {
    enable = true;                               # Enable Gitea
    appName = "Gitea";                           # Give the site a name
    database = {
      type = "postgres";                         # Database type
      passwordFile = config.sops.secrets."postgres/gitea_dbpass".path;
    };
    settings.server.DOMAIN = "gitea.c4er.com";                   # Domain name
    settings.server.ROOT_URL = "https://gitea.c4er.com/";         # Root web URL
    settings.server.HTTP_PORT = 3001;   
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "matttest" config.services.gitea.user ];
    ensureUsers = [
      {
        name = config.services.gitea.database.user;
        ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  services = {
    syncthing = {
      enable = true;
      user = "matt";
      dataDir = "/mnt/storage/syncthing/personal";
      configDir = "/mnt/storage/syncthing/config";
    };
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
  networking.extraHosts =
  ''
    127.0.0.2 other-localhost
    127.0.0.1 c4er.com
    127.0.0.1 gitea.c4er.com
    127.0.0.1 grafana.c4er.com
    127.0.0.1 hydra.c4er.com
    127.0.0.1 woodpecker.c4er.com
  '';

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
    argocd
    certbot-full
    gitea
    k3s
    k9s
    kubernetes-helm-wrapped
    morph
    nebula
    nodejs
    pocketbase
    sops
    syncthing
    tmux
    wezterm
    waypipe
    firefox
    signal-desktop
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    80   # caddy http
    443  # caddy https
    6443 # k3s
    8090 # pocketbase
    8384 # syncthing
    22000 #syncthing
  ];
  networking.firewall.allowedUDPPorts = [ 
    22000 #syncthing
    21027 #syncthing
  ];
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

