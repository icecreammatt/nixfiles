{ config, pkgs, ... }:

{

  # nixpkgs.config.allowUnfree = true;
  time.timeZone = "America/Los_Angeles";

  users.users.matt = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fish
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.extraHosts = ''
    192.168.100.1 lighthouse
    192.168.100.10 mini
    192.168.100.11 asahi
    192.168.100.12 gaming
    192.168.100.13 dockingbay94
    192.168.100.14 octoprint
    192.168.100.15 wololo
  '';

  environment.systemPackages = with pkgs; [
     fish
     git
     helix
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
  ];

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  services.openssh.enable = true;
}
