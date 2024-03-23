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
  hostName = "mini-iso";
  pkgs = import nixpkgs {
    config.allowUnfree = true;
    system = "${system}";
    overlays = [
      (import ../../../overlay/overlay.nix)
    ];
  };
in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;

  home-manager = {
    extraSpecialArgs = {inherit pkgs;};
    users."${user}" = {
      imports = [
        ../../../modules/options.nix
        ../../../modules/shell/starship.nix
        ../../../modules/common.nix
      ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "nodev";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    variant = "";
    # xkbVariant = lib.mkIf useColemak "colemak_dh";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    morph
    nil
    tmux
    wezterm
    yazi
  ];

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
