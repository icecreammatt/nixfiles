# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  user,
  system,
  nixpkgs,
  ...
}: let
  hostname = "gaming";
  nixos_plymouth = pkgs.callPackage ./nixos-plymouth.nix {};

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
    ./udev.nix
    # ../mini/caddy.nix
    ../../../modules/airplay/uxplay.nix
    ../../../modules/DE/xremap.nix
    ../../../modules/editors/arduino.nix
  ];

  home-manager = {
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit pkgs;};
    users."${user}" = {
      imports = [
        ../gaming/nixos-packages.nix
        ../../../modules/common.nix
        ../../../modules/common-linux.nix
        ../../../modules/common-linux-gui.nix
        ../../../modules/shell/git.nix
        ../../../modules/rust.nix
        ../../../modules/DE/rofi.nix
        # ../../modules/DE/hypr.nix
        # ../../modules/DE/waybar.nix
      ];
    };
  };

  system.autoUpgrade.enable = false;
  services.blueman.enable = true;

  # Closed source driver
  services.xserver.videoDrivers = ["nvidia"];

  # Use open source driver
  # services.xserver.videoDrivers = ["nouveau"];
  # boot.blacklistedKernelModules = ["nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset"];

  services.flatpak.enable = true;

  # environment.etc."modprobe.d/nouveau.conf".text = ''
  # options nouveau modeset=1
  # '';

  hardware = {
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    graphics.enable = true;

    # graphics.extraPackages = with pkgs; [
    # Add packages needed for Nouveau acceleration here
    # For example, Mesa for OpenGL:
    # mesa
    # mesa.drivers
    # ];

    # Nvidia
    nvidia = {
      nvidiaPersistenced = true;
      modesetting.enable = true;
      open = true; # use nvidia driver switch this to true to use nouveau open source driver

      # https://github.com/NixOS/nixpkgs/blob/d0797a04b81caeae77bcff10a9dde78bc17f5661/pkgs/os-specific/linux/nvidia-x11/default.nix#L48-L77
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      # persistencedSha256 = lib.fakeSha256;

      # Doesn't boot with kde plasma6 on 6.11.5 kernel version
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.58.02";
      #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
      # };

      # nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
      # https://github.com/NixOS/nixpkgs/commit/7c810fab6d18f9ee3be8113222b95cc2aa5e643d

      # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
      # package =
      # Example how to patch driver
      # let
      # rcu_patch = pkgs.fetchpatch {
      #   url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
      #   hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
      # };
      # in
      # Pin to specific working driver until gamescope works well with 550 series
      # config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "550.67";
      #   sha256_64bit = "sha256-mSAaCccc/w/QJh6w8Mva0oLrqB+cOSO1YMz1Se/32uI=";
      #   sha256_aarch64 = "sha256-+UuK0UniAsndN15VDb/xopjkdlc6ZGk5LIm/GNs5ivA=";
      #   openSha256 = "sha256-M/1qAQxTm61bznAtCoNQXICfThh3hLqfd0s1n1BFj2A=";
      #   settingsSha256 = "sha256-FUEwXpeUMH1DYH77/t76wF1UslkcW721x9BHasaRUaM=";
      #   persistencedSha256 = "sha256-ojHbmSAOYl3lOi2X6HOBlokTXhTCK6VNsH6+xfGQsyo=";

      # Stable with games
      # version = "535.154.05";
      # sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      # sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      # openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      # settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      # persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

      # Unstable with gamescope
      #version = "550.40.07";
      #sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
      #sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
      #openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
      #settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
      #persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

      # patches = [rcu_patch];
      # };
    };
  };

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = "experimental-features = nix-command flakes";
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
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [config.services.gitea.user];
    ensureUsers = [
      {
        name = config.services.gitea.database.user;

        # trace: warning:
        #       `services.postgresql.ensureUsers.*.ensurePermissions` is used in your expressions,
        #       this option is known to be broken with newer PostgreSQL versions,
        #       consider migrating to `services.postgresql.ensureUsers.*.ensureDBOwnership` or
        #       consult the release notes or manual for more migration guidelines.

        #       This option will be removed in NixOS 24.05 unless it sees significant
        #       maintenance improvements.

        # ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
        # using ensureDBOwnership instead of older command above
        ensureDBOwnership = true;
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
  # Add Kernel patch for Line6 TonePort UX1
  # To us 24-bit audio 48000hz audio as confirmed by Line6 support
  # Source: https://www.reddit.com/r/linuxaudio/comments/blun53/anyone_know_good_settings_for_jack_with_line_6/
  # Credit: goes to /u/wolfgothmog and myself to update their work
  # to be compatible with latest Kernel which at this time is 6.1.28
  # as toneport.c had some changes since that post.
  # I'm using ProSonus now but keeping this around if I need to ever switch back and for reference
  # boot.kernelPatches = [
  #   {
  #     name = "toneport-patch";
  #     patch = ../../../modules/kernel/toneport.patch;
  #   }
  # ];

  # Disable waybar for now since not using to speed up build times
  # nixpkgs.overlays = [
  #   (self: super: {
  #     waybar = super.waybar.overrideAttrs (oldAttrs: {
  #       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #     });
  #   })
  # ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  # Gamescope overrides (fails to build but leaving as example for later versions)
  # nixpkgs.config.packageOverrides = pkgs.gamescope.overrideAttrs (_: oldAttrs: {
  #   src = pkgs.fetchFromGitHub {
  #     owner = "ValveSoftware";
  #     repo = "gamescope";
  #     rev = "ee0143a8792b03cd64e3f29b074b299c498d14af";
  #     fetchSubmodules = true;
  #     hash = "sha256-ZTlJeFf0EZfeHGoEGQSewxdhU2x5gP6MureY24kZuJk=";
  #   };

  #   buildInputs = oldAttrs.buildInputs ++ [pkgs.libdecor];
  # });

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          #cmake
          #pkg-config
          #libevdev
          # pkgs.xorg.libX11
          # gcc
        ];
    };
    #    environment.systemPackages = [ pkgs.gamescope pkgs.mangohud ];
  };

  console = {
    #font = "ter-132n";
    #packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  fonts.packages = with pkgs; [meslo-lgs-nf];
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      font-name=MesloLGS NF
      font-size=14
    '';
  };

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];

    # Bootloader.
    loader.timeout = 0;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = ["quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"];
    kernelPackages = pkgs.linuxPackages_latest;

    # Pretty boot
    plymouth = {
      enable = true;
      theme = "nixos-blur";
      themePackages = [nixos_plymouth];
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  time.hardwareClockInLocalTime = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  #services.xserver.desktopManager.gnome.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    # xkbVariant = "colemak_dh,";
  };

  # users = {
  #   mutableUsers = false;
  #   users.${user}.password = "test";
  # };

  virtualisation.vmVariant = {
    # nixos-rebuild build-vm --flake .#gaming
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192; # Use 2048MiB memory.
      cores = 12;
      graphics = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.defaultUserShell = pkgs.fish;
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    bitwarden
    blender
    devbox
    # cage
    firefox
    gamescope
    glxinfo
    killall
    lm_sensors
    mangohud
    #neovim
    nodejs
    sops
    sublime-merge
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    waybar
    waypipe

    # Wine for Ableton (Using Steam Proton instead)
    # wine64
    # wine
    # winetricks

    # sunshine
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

  networking = {
    hostName = hostname; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    extraHosts = ''
      127.0.0.1 gaming.dev.c4er.com
      127.0.0.1 rewind.dev.c4er.com
    '';

    # Firewall ports only for Nebula VPN users
    firewall.interfaces."nebula1".allowedTCPPorts = [
      34197 # Factorio
    ];

    # Firewall ports only for Nebula VPN users
    firewall.interfaces."nebula1".allowedUDPPorts = [
      34197 # Factorio
    ];

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [
      # sunshine
      # 47984
      # 47989
      # 48010
    ];
    firewall.allowedUDPPorts = [
      # sunshine
      # 47998
      # 47999
      # 48000
    ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
