# This file is the entrypoint into all the system configurations
{
  description = "System configuration for NixOS, Mac, Asahi, RaspberryPi, NixOS VMs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/eec8ab29d940ca666c73629a8dab0cc536a90d99";

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

    # Keyboard hotkey remapping
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Text editor branch
    toolong = {
      url = "github:icecreammatt/toolong";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Text editor branch
    helix-flake = {
      url = "github:icecreammatt/helix/refs/tags/2024-01-29";
      # changing this to follows will cause a build error herer
      # put this back to follows after rebasing my fork
      # inputs.nixpkgs.follows = "nixpkgs";
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
    sops-nix,
    helix-flake,
    xremap-flake,
    ...
  }: let
    user = "matt";
    username = "Matt Carrier";
    darkmode = true;
  in {
    # Gaming PC, Mini, VM, Raspberry Pi
    nixosConfigurations = (
      import ./hosts/nixos {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixos-hardware home-manager sops-nix helix-flake user username darkmode;
      }
    );

    # Asahi Linux (M1 Mac)
    asahiConfiguration = (
      import ./hosts/asahi {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager sops-nix helix-flake user username darkmode;
      }
    );

    # Mac x86_64/aarch64 configs
    darwinConfigurations = (
      import ./hosts/darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin user username darkmode;
      }
    );
  };
}
