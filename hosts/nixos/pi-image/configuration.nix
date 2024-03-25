# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  nixpkgs,
  lib,
  system,
  user,
  modulesPath,
  useColemak,
  ...
}: let
  hostName = "dockingbay95";
  pkgs = import nixpkgs {
    config.allowUnfree = true;
    system = "${system}";
    overlays = [
      (import ../../../overlay/overlay.nix)
    ];
  };
in {
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix"
    ../pi4/hardware-configuration.nix
  ];

  sdImage.compressImage = false;

  nixpkgs.hostPlatform = lib.mkDefault system;

  home-manager = {
    extraSpecialArgs = {inherit pkgs;};
    users."${user}" = {
      imports = [
        ../../../modules/common.nix
      ];
    };
  };

  # Rasperry Pi Specific Settings

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # !!! Set to specific linux kernel version
  # boot.kernelPackages = pkgs.linuxPackages_5_4;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
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

  # WiFi
  hardware = {
    enableRedistributableFirmware = true;
    firmware = [pkgs.wireless-regdb];
  };

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
  services.xserver.xkb = {
    layout = "us";
    # variant = "";
    # xkbVariant = lib.mkIf useColemak "colemak_dh";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    caddy
    docker
    docker-compose
    morph
    nebula
    syncthing
    tmux
  ];

  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmdl6XNEdT+EWf1IDRjHAygUIGpNCaBv9Qhm19cRCEm"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEIXyeLJp8xzA2Kth9fsNk8L4U5gQbQsdS5jRAwShgVj matt@gaming"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGi7DLE/5v9yI2ZRPeKOftyngeNMvXOX/RDIyA0J3rtI matt@mini"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRq7YNesYqVvBoM/ncl8G6cUglY64jCOv3Lr5JtSaMQ matt@asahi"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBboyvMOlaz8Z5swY9sWwNbu7LdHrYG7dhxXn31Fe4we matt@fedora"
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  networking = {
    hostName = hostName; # Define your hostname.

    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    extraHosts = ''
      127.0.0.2 other-localhost
    '';

    # Open ports on all interfaces in the firewall.
    firewall.allowedTCPPorts = [];
    firewall.allowedUDPPorts = [];
    # Or disable the firewall altogether.
    firewall.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
