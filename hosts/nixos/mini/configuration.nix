# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  user,
  nixpkgs,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    config.allowUnfree = true;
    system = "${system}";
    overlays = [
      (import ../../../overlay/overlay.nix)
    ];
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../../modules/vpn/nebula.nix
    # ../../../modules/DE/kde/plasma.nix
    ../../../modules/apps/vaultwarden.nix
    ../../../modules/apps/navidrone.nix
    ../../../modules/ci/hydra.nix
    ./caddy.nix
    ./kopia.nix
    ./logging.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit pkgs;};
    users."${user}" = {
      imports = [
        ../../../modules/common.nix
        ../../../modules/rust.nix
        ../../../modules/k8s.nix
      ];
    };
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     yazi = prev.yazi.overrideAttrs (oldAttrs: {
  #       buildInputs = oldAttrs.buildInputs ++ [pkgs.makeWrapper];
  #       # wrap the binary in a script where the appropriate env var is set
  #       postInstall =
  #         oldAttrs.postInstall
  #         or ""
  #         + ''
  #           wrapProgram "$out/bin/yazi" --set TERM_PROGRAM "WezTerm"
  #         '';
  #     });
  #   })
  # ];

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [user];
  users.users.${user}.extraGroups = ["docker"];

  # sops.secrets."attic/ATTIC_SERVER_TOKEN_HS256_SECRET_BASE64" = {
  #   sopsFile = ../../../.secrets/attic.ini;
  #   format = "ini";
  # };

  programs.keyboard-dev = {
    enable = false;
  };

  # services.atticd = {
  #   enable = true;
  #   # package = pkgs.attic;

  #   # Replace with absolute path to your credentials file
  #   # credentialsFile = "/etc/atticd.env";
  #   credentialsFile = config.sops.secrets."attic/ATTIC_SERVER_TOKEN_HS256_SECRET_BASE64".path; # "/path/to/my/secrets/file";

  #   settings = {
  #     listen = "127.0.0.1:8072";

  #     storage = {
  #       type = "local";
  #       path = "/tmp/attic";
  #     };

  #     # Data chunking
  #     #
  #     # Warning: If you change any of the values here, it will be
  #     # difficult to reuse existing chunks for newly-uploaded NARs
  #     # since the cutpoints will be different. As a result, the
  #     # deduplication ratio will suffer for a while after the change.
  #     chunking = {
  #       # The minimum NAR size to trigger chunking
  #       #
  #       # If 0, chunking is disabled entirely for newly-uploaded NARs.
  #       # If 1, all NARs are chunked.
  #       nar-size-threshold = 64 * 1024; # 64 KiB

  #       # The preferred minimum size of a chunk, in bytes
  #       min-size = 16 * 1024; # 16 KiB

  #       # The preferred average size of a chunk, in bytes
  #       avg-size = 64 * 1024; # 64 KiB

  #       # The preferred maximum size of a chunk, in bytes
  #       max-size = 256 * 1024; # 256 KiB
  #     };
  #   };
  # };
  # systemd.services.atticd.serviceConfig.ReadWritePaths = "/tmp/attic";

  # systemd.timers."gauge-check" = {
  #   wantedBy = ["timers.target"];
  #   timerConfig = {
  #     OnBootSec = "1m";
  #     OnUnitActiveSec = "1m";
  #     Unit = "gauge-check.service";
  #   };
  # };

  # systemd.services."gauge-check" = {
  #   script = ''
  #     TARGET_NAME="/mnt/storage/webroot/pool/pressure-$(date +"%Y%m%d_%H%M%S.%N").jpg"
  #     ${pkgs.openssh}/bin/ssh -i /home/${user}/.ssh/webcam pi@192.168.50.19 fswebcam -r 1280x1024 --jpeg 90 -D 1 web-cam-shot.jpg
  #     ${pkgs.openssh}/bin/scp -i /home/${user}/.ssh/webcam pi@192.168.50.19:web-cam-shot.jpg $TARGET_NAME
  #     ${pkgs.uutils-coreutils-noprefix}/bin/ln -f $TARGET_NAME /mnt/storage/webroot/pool/_latest.jpg
  #     ${pkgs.imagemagick}/bin/convert /mnt/storage/webroot/pool/_latest.jpg -gravity center -crop 100x100+190+110 +repage /mnt/storage/webroot/pool/_cropped.jpg
  #     ${pkgs.imagemagick}/bin/convert /mnt/storage/webroot/pool/_cropped.jpg -resize 900 -sigmoidal-contrast 30x50% -colorspace Gray /mnt/storage/webroot/pool/_zoomed.jpg
  #   '';

  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #   };
  # };

  virtualisation.vmVariant = {
    # nixos-rebuild build-vm --flake .#mini
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
    virtualisation.forwardPorts = [
      {
        from = "host";
        host.port = 8888;
        guest.port = 80;
      }
      {
        from = "host";
        host.port = 2121;
        guest.port = 22;
      }
    ];
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      silverbullet = {
        ports = ["127.0.0.1:3071:3000"];
        image = "gitea.c4er.com/matt/silverbullet:0.6.1";
        # image = "zefhemel/silverbullet:latest";
        # command = [ "/bin/sh" ];
        # args = [ "-c" "echo 'Hello, world!'" ];
        volumes = [
          "/home/${user}/SyncWork/Notes/Notes:/space"
        ];
        # restartPolicy = "always";
      };

      metube = {
        ports = ["127.0.0.1:8081:8081"];
        image = "ghcr.io/alexta69/metube:latest";
        volumes = [
          "/home/${user}/downloads/metube:/downloads"
        ];
      };

      excalidraw = {
        ports = ["127.0.0.1:8085:80"];
        image = "excalidraw:latest";
      };
    };
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "8087";
    };
  };

  systemd.services.rewind-server = {
    enable = true;
    description = "rewind-server";
    path = [pkgs.nodejs];
    serviceConfig = {
      WorkingDirectory = /mnt/storage/rewind-server;
      Type = "simple";
      Environment = [
        "PORT=4173"
        "HOST=127.0.0.1"
      ];
      ExecStart = "${pkgs.nodejs}/bin/node build";
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.rewind-db = {
    enable = true;
    description = "rewind-db";
    serviceConfig = {
      ExecStart = "/home/${user}/pocketbase/pocketbase serve";
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };

  services.k3s.enable = false;
  services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
  # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  services.woodpecker-server = {
    enable = true;
    environment = {
      WOODPECKER_HOST = "https://woodpecker.c4er.com";
      WOODPECKER_SERVER_ADDR = ":3007";
      WOODPECKER_OPEN = "true";

      WOODPECKER_ADMINS = user;
      WOODPECKER_ADMIN = user;
      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://gitea.c4er.com";
    };
    # You can pass a file with env vars to the system it could look like:
    # WOODPECKER_AGENT_SECRET=XXXXXXXXXXXXXXXXXXXXXX
    environmentFile = config.sops.secrets."woodpecker/WOODPECKER_AGENT_SECRET".path; # "/path/to/my/secrets/file";
  };

  # This sets up a woodpecker agent
  services.woodpecker-agents.agents."docker" = {
    enable = true;
    # We need this to talk to the podman socket
    extraGroups = ["docker"];
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
  sops.age.keyFile = "/home/${user}/.config/sops/age/keys.txt";

  services.gitea = {
    enable = true; # Enable Gitea
    appName = "Gitea"; # Give the site a name
    database = {
      type = "postgres"; # Database type
      passwordFile = config.sops.secrets."postgres/gitea_dbpass".path;
    };
    settings.server.DOMAIN = "gitea.c4er.com"; # Domain name
    settings.server.ROOT_URL = "https://gitea.c4er.com/"; # Root web URL
    settings.server.HTTP_PORT = 3001;
    # This needs to be far left indented or it will not parse properly in gitea
    extraConfig = "
[webhook]
ALLOWED_HOST_LIST=woodpecker.c4er.com
    ";
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["matttest" config.services.gitea.user];
    ensureUsers = [
      {
        name = config.services.gitea.database.user;
        #ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
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
      user = user;
      dataDir = "/mnt/storage/syncthing/personal";
      configDir = "/mnt/storage/syncthing/config";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "nodev";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mini"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # nixpkgs.config.allowUnfree = true;
  networking.extraHosts = ''
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
    docker-compose
    filebrowser
    imagemagick
    kubernetes-helm-wrapped
    lego #certbot lets encrypt
    mkdocs
    morph
    nebula
    nil
    nodejs
    pocketbase
    restic
    uptime-kuma
    sops
    syncthing
    tmux
    wezterm
    waypipe
    firefox
    yazi
    signal-desktop
  ];

  # Firewall ports only for Nebula VPN users
  networking.firewall.interfaces."nebula1".allowedTCPPorts = [
    80 # caddy http
    443 # caddy https
    2015 # quickweb
    6443 # k3s
    8090 # pocketbase
  ];

  # Open ports on all interfaces in the firewall.
  networking.firewall.allowedTCPPorts = [
    8384 # syncthing
    8072 # attic
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
