# This file is the entrypoint into all the system configurations

{
  description = "System configuration for NixOS, Mac, Asahi, RaspberryPi, NixOS VMs";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Configuration and Program Management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mac System Configuration
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Linux Desktop Window Manager
    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, darwin, hyprland, ... }:
    let
      userConfig.user = {
        firstName = "Matt";
        lastName = "Carrier";
        email = "placeholder@example.com";
      };
    in
    {

      # Gaming PC, VM, Raspberry Pi
      nixosConfigurations = (
        import ./hosts/nixos {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixos-hardware home-manager userConfig;
        }
      );

      # M1 Mac + Linux config
      asahiConfiguration = (
        import ./hosts/asahi {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager userConfig;
        }
      );

      # Mac x86_64/aarch64 configs
      darwinConfigurations = (
        import ./hosts/darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager darwin userConfig;
        }
      );

  };
}
