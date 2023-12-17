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
    notificationSender = "hydra@localhost"; # e-mail of hydra service
    hydraURL = "http://localhost:3000";
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
    127.0.0.1 hydra.c4er.com
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

