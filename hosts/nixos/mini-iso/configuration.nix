# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  #config,
  pkgs,
  # user,
  modulesPath,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    #../mini/hardware-configuration.nix
    #../../../modules/vpn/nebula.nix
    #../../../modules/DE/kde/plasma.nix
    #../../../modules/apps/vaultwarden.nix
    #../../../modules/apps/navidrone.nix
    #../../../modules/ci/hydra.nix
    #../mini/caddy.nix
    #../mini/kopia.nix
    #../mini/logging.nix
  ];

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

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "nodev";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mini-vm"; # Define your hostname.
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    morph
    nebula
    nil
    tmux
    wezterm
    yazi
  ];

  # Firewall ports only for Nebula VPN users
  networking.firewall.interfaces."nebula1".allowedTCPPorts = [
    2015 # quickweb
  ];

  # Open ports on all interfaces in the firewall.
  networking.firewall.allowedTCPPorts = [
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
