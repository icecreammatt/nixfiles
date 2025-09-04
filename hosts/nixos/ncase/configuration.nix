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
  hostname = "nixos";

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
    # ./hardware-configuration.nix
    # ./udev.nix
    # ../../../modules/airplay/uxplay.nix
    # ../../../modules/DE/xremap.nix
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
        # ../../../modules/DE/rofi.nix
        # ../../modules/DE/waybar.nix
      ];
    };
  };
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
  programs.neovim.enable = true;
  #
  # Enable systemd-boot for EFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Unlock LUKS device
  boot.initrd.luks.devices.cryptroot = {
    device = "/dev/nvme0n1p2";
    preLVM = false; # no LVM
  };

  # File systems and Btrfs subvolumes
  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/persist" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [
      "subvol=@persist"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/nix" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/var/log" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [
      "subvol=@varlog"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/boot/efi" = {
    # device = "/dev/nvme0n1p1";
    device = "/dev/disk/by-uuid/45F4-CD57";
    fsType = "vfat";
  };

  # Setup swapfile inside swap subvolume
  swapDevices = [
    {
      device = "/swap/swapfile";
      # Must be inside mounted /swap subvolume
      size = 8192; # size in MB
    }
  ];

  # Impermanence settings
  # Mount /tmp and /var as tmpfs to reset on reboot
  fileSystems."/tmp".device = "tmpfs";
  fileSystems."/tmp".fsType = "tmpfs";

  fileSystems."/var".device = "tmpfs";
  fileSystems."/var".fsType = "tmpfs";

  # Persist directory is mounted separately to save user data
  # This aligns with the impermanence model
  environment.persistence."/nix/persist/system" = {
    hideMounts = false;
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
      {file = "/etc/nix/id_rsa";}
    ];
  };

  environment.persistence."/nix/persist/home" = {
    hideMounts = false;
    directories = [
      "/matt"
    ];
    files = [];
  };

  # Enable zstd compression by default
  boot.kernelParams = ["zstd.enabled=1"];

  # Networking, users, etc., adjust as needed
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = ["wheel"];
    packages = [
      pkgs.neovim
      # pkgs.helix
      pkgs.git
    ];
  };

  virtualisation.vmVariant = {
    # nixos-rebuild build-vm --flake .#ncase
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

  system.autoUpgrade.enable = false;
  # services.blueman.enable = true;
  services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;
  # services.geoclue2.enable = false;

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

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
    graphics.enable32Bit = true;

    # graphics.extraPackages = with pkgs; [
    # Add packages needed for Nouveau acceleration here
    # For example, Mesa for OpenGL:
    # mesa
    # mesa.drivers
    # ];

    # Nvidia
    nvidia = {
      # https://wiki.nixos.org/wiki/NVIDIA
      open = true; # use nvidia driver switch this to true to use nouveau open source driver
      nvidiaSettings = true;
      nvidiaPersistenced = false;
      modesetting.enable = true;

      # https://github.com/NixOS/nixpkgs/commits/master/pkgs/os-specific/linux/nvidia-x11

      # https://github.com/NixOS/nixpkgs/blob/d0797a04b81caeae77bcff10a9dde78bc17f5661/pkgs/os-specific/linux/nvidia-x11/default.nix#L48-L77
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      package = config.boot.kernelPackages.nvidiaPackages.latest;

      # nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
      # https://github.com/NixOS/nixpkgs/commit/7c810fab6d18f9ee3be8113222b95cc2aa5e643d
    };
  };

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = "experimental-features = nix-command flakes";
  };

  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${user}/.config/sops/age/keys.txt";

  programs.niri.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

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
    hwRender = false;
    extraConfig = ''
      font-name=MesloLGS NF
      font-size=14
    '';
  };

  boot = {
    # Bootloader.
    loader.timeout = 5;
    # loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.systemd-boot.configurationLimit = 10;
    # loader.efi.canTouchEfiVariables = true;
    # loader.efi.efiSysMountPoint = "/boot/efi";

    consoleLogLevel = 0;
    initrd.verbose = false;
    # kernelParams = ["quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  time.hardwareClockInLocalTime = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  programs.partition-manager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
    settings = {
      Users = {
        RememberLastUser = false;
        LastUser = "matt";
      };
    };
  };
  services.displayManager.defaultSession = "niri";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    # xkbVariant = "colemak_dh,";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.polkit.enable = true;
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
  # users.users.${user} = {
  #   isNormalUser = true;
  #   extraGroups = ["networkmanager" "wheel"];
  # };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    pantheon.pantheon-agent-polkit
    efibootmgr
    dive
    s-tui
    fuzzel
    podman-tui
    (pkgs.catppuccin-sddm.override
      {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "12";
        # background = "${./wallpaper.png}";
        loginBackground = true;
      })
    (pkgs.btop.overrideAttrs (oldAttrs: {
      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          # "-DBTOP_RSMI_STATIC=ON"
          "-DBTOP_GPU=ON"
        ];
    }))
    docker-compose
    bitwarden
    blender
    devbox
    distrobox
    # cage
    firefox
    liquidctl # control kraken
    gamescope
    glxinfo
    killall
    lm_sensors
    mangohud
    #neovim
    nodejs
    sops
    # prusa-slicer
    sublime-merge
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # waybar
    waypipe
    swaybg
    mako
    xwayland-satellite
    vlc

    obs-studio
    # shipwright
    # _2ship2harkinian

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
    enable = false;
    description = "nebula";
    serviceConfig = {
      ExecStart = "${pkgs.nebula}/bin/nebula -config /etc/nebula/config.yaml";
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.kraken = {
    enable = true;
    description = "liquidctl (kraken aio control)";
    script = ''
      ${pkgs.liquidctl}/bin/liquidctl initialize all
      ${pkgs.liquidctl}/bin/liquidctl --bus hid --address /dev/hidraw1 set ring color fading FF0000 FF0000 # set color to red
    '';
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
      2015
      # 34197 # Factorio
      # 27100 # Perfect Dark
    ];

    # Firewall ports only for Nebula VPN users
    firewall.interfaces."nebula1".allowedUDPPorts = [
      # 34197 # Factorio
      # 27100 # Perfect Dark
    ];

    firewall.interfaces."nebula1".allowedTCPPortRanges = [
      # KDE Connect
      # {
      #   from = 1714;
      #   to = 1764;
      # }
    ];
    firewall.interfaces."nebula1".allowedUDPPortRanges = [
      # KDE Connect
      # {
      #   from = 1714;
      #   to = 1764;
      # }
    ];

    # Open ports in the firewall.
    firewall.allowedTCPPortRanges = [
      # KDE Connect
      # {
      #   from = 1714;
      #   to = 1764;
      # }
    ];

    firewall.allowedTCPPorts = [
      2015
      # sunshine
      # 47984
      # 47989
      # 48010
    ];

    firewall.allowedUDPPortRanges = [
      # KDE Connect
      # {
      #   from = 1714;
      #   to = 1764;
      # }
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
  system.stateVersion = "25.11"; # Did you read the comment?
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
