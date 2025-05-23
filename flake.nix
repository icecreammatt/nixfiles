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
      # url = "github:icecreammatt/helix/refs/tags/blame";
      url = "git+https://github.com/icecreammatt/helix?rev=e477182701b92b3a69b41af4cc2b2d63518e9c91";
      # url = "git+file:///Users/mcarrier/Source/icecreammatt/helix";
      #
      # changing this to follows will cause a build error herer
      # put this back to follows after rebasing my fork
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # prusa-flake = {
    # url = "https://github.com/prusa3d/PrusaSlicer.git";
    # rev = "version_2.9.2";
    # sha256 = "05zwwhqv3fjg9rx6a4ga55f4ic1136f6lwms0kb4kaq50w9dvxwg";
    # };

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
