{ lib, inputs, nixpkgs, nixos-hardware, home-manager, hyprland, userConfig, ... }:

let
    system = "x86_64-linux";
    # system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  # system = "aarch64-linux";
  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;
  # };
  # lib = nixpkgs.lib;
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
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    modules = [
      ./vm/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [ 
            ../modules/core.nix
            ../modules/rust.nix
          ];
        };
      }
    ];
  };

  dockingbay94 = lib.nixosSystem {
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    modules = [
      nixos-hardware.nixosModules.raspberry-pi-4
      ./pi4/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [ 
            ../modules/core.nix
          ];
        };
      }
    ];
  };

   gaming = lib.nixosSystem {
    # system = "x86_64-linux";
    inherit system;
    inherit pkgs;
    # pkgs = import nixpkgs {
    #   config.allowUnfree = true;
    # };
    modules = [
      ./gaming/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [ 
            ./gaming/nixos-packages.nix
            ../modules/core.nix
    		    ../modules/common.nix
    		    ../modules/common-linux.nix
    		    ../modules/rust.nix
    		    ../modules/DE/hypr.nix
    		    ../modules/DE/waybar.nix
    		    ../modules/DE/rofi.nix
    		    ../modules/shell/kitty.nix
          ];
        };
      }
	    hyprland.nixosModules.default {
	      programs.hyprland.enable = true; 
	    }
    ];
  };

}