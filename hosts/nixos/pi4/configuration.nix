# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.firewall.allowedTCPPorts = [ 6443 ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelParams = [
    "cgroup_enable=cpuset" "cgroup_memory=1" "cgroup_enable=memory"
  ];

  networking.hostName = "dockingbay94"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.extraHosts =
  ''
    127.0.0.2 other-localhost
  '';


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
    # users.users.matt = {
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
      k3s
      nebula
      caddy
    ];
    # environment.shells = with pkgs; [ zsh fish ];

  services.caddy = {
    enable = true;

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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    443
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

