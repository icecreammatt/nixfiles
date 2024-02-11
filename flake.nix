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

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
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

    # Keyboard hotkey remapping
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Text editor branch
    helix-flake = {
      url = "github:icecreammatt/helix/refs/tags/2024-01-29";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Build caching
    attic = {
      url = "github:zhaofengli/attic";
    };

    # Simple example on how to use flake input
    worm = {
      url = "github:icecreammatt/ssu-cs315-worm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    darwin,
    hyprland,
    sops-nix,
    helix-flake,
    xremap-flake,
    attic,
    ...
  }: let
    user = "matt";
  in {
    # Gaming PC, Mini, VM, Raspberry Pi
    nixosConfigurations = (
      import ./hosts/nixos {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixos-hardware home-manager hyprland sops-nix helix-flake attic user;
      }
    );

    # Asahi Linux (M1 Mac)
    asahiConfiguration = (
      import ./hosts/asahi {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager sops-nix helix-flake user;
      }
    );

    # Mac x86_64/aarch64 configs
    darwinConfigurations = (
      import ./hosts/darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin;
      }
    );
  };
}
