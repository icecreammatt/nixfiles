{
  user,
  lib,
  username,
  darkmode,
  system,
  inputs,
  nixpkgs,
  ...
}: let
  pkgs = import nixpkgs {
    config.allowUnfree = true;
    system = "${system}";
    overlays = [
      (import ../../overlay/overlay.nix)
    ];
  };
in {
  imports = [
    ./networking.nix
    ../../modules/keyboard-dev.nix
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Los_Angeles";

  users.defaultUserShell = pkgs.fish;

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmdl6XNEdT+EWf1IDRjHAygUIGpNCaBv9Qhm19cRCEm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEIXyeLJp8xzA2Kth9fsNk8L4U5gQbQsdS5jRAwShgVj matt@gaming"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGi7DLE/5v9yI2ZRPeKOftyngeNMvXOX/RDIyA0J3rtI matt@mini"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRq7YNesYqVvBoM/ncl8G6cUglY64jCOv3Lr5JtSaMQ matt@asahi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBboyvMOlaz8Z5swY9sWwNbu7LdHrYG7dhxXn31Fe4we matt@fedora"
    ];
    shell = pkgs.fish;
    isNormalUser = true;
    description = "${user}";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fish
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    inputs.helix-flake.packages."${system}".default
    inputs.toolong.packages."${system}".toolong
    fish
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkDefault "no";
      PasswordAuthentication = false;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit user username darkmode;};
    users."${user}" = {
      home.stateVersion = "23.11";
      imports = [
        ../../modules/core.nix
        ../../modules/shell/git.nix
      ];
    };
  };
}
