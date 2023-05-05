{ lib, inputs, nixpkgs, nixos-hardware, home-manager, hyprland, ... }:

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
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
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

  vm2 = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
    };
    modules = [
      ./config-common.nix
      ./vm2/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ../../modules/core.nix
            ../../modules/common.nix
            ../../modules/rust.nix
          ];
        };
      }
    ];
  };

   gaming = lib.nixosSystem {

    # inherit hyprland;
    # inherit system;
    # inherit pkgs;

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      system = "x86_64-linux";
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
    };
    modules = [
      ./gaming/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ./gaming/nixos-packages.nix
            ../../modules/core.nix
            ../../modules/common.nix
            ../../modules/common-linux.nix
            ../../modules/common-linux-gui.nix
            ../../modules/rust.nix
            ../../modules/DE/hypr.nix
            ../../modules/DE/waybar.nix
            ../../modules/DE/rofi.nix
            ../../modules/shell/kitty.nix
          ];
        };
      }

      hyprland.nixosModules.default {
        programs.hyprland.enable = false;
      }
    ];
  };

  dockingbay94 = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
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
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
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
            ../../modules/common.nix
            ../../modules/rust.nix
            ../../modules/k8s.nix
          ];
        };
      }
    ];
  };

}
