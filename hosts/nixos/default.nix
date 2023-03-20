{ lib, inputs, nixpkgs, nixos-hardware, home-manager, ... }:

let
  system = "aarch64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
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
    inherit system;
    inherit pkgs;
    modules = [
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
    inherit system;
    inherit pkgs;
    modules = [
      nixos-hardware.nixosModules.raspberry-pi-4
      ./pi4/configuration.nix
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

}