{ lib, inputs, nixpkgs, nixos-hardware, home-manager, ... }:

let
  user = "matt";

  # nixpkgs.overlays = [(self: super:
  #   helix = super.helix.overrideAttrs (old: {
  #     src = super.fetchFromGitHub {
  #       owner = "icecreammatt";
  #       repo = "helix";
  #       rev = "6b7d292d29cb03739cdcb3bf82033d995aa4fad3";
  #     };
  #   });
  # )];

in
{
  nixos-vm = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
    };
    modules = [
      ./config-common.nix
      ./vm/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ../../modules/core.nix
            ../../modules/rust.nix
          ];
        };
      }
    ];
  };

  dockingbay94 = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
    };
    modules = [
      nixos-hardware.nixosModules.raspberry-pi-4
      ./config-common.nix
      ./pi4/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ../../modules/core.nix
            ../../modules/rust.nix
            ../../modules/k8s.nix
          ];
        };
      }
    ];
  };

  mini = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    modules = [
      ./config-common.nix
      ./mini/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ../../modules/core.nix
            ../../modules/rust.nix
            ../../modules/k8s.nix
          ];
        };
      }
    ];
  };

}
