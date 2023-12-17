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
