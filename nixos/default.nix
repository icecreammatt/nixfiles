{ lib, inputs, nixpkgs, home-manager, userConfig, ... }:

let
  system = "aarch64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
  user = "matt";
  nixpkgs.overlays = [(self: super: 

    helix = super.helix.overrideAttrs (old: {
      src = super.fetchFromGitHub {
        owner = "icecreammatt";
        repo = "helix";
        rev = "6b7d292d29cb03739cdcb3bf82033d995aa4fad3";
      };
    });
   
  )];
in
{
  nixos-vm = lib.nixosSystem {
    inherit system;
    inherit pkgs;
    modules = [
      # ./nix-os-flakes/configuration.nix
      ./vm/configuration.nix
	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.matt = {
          home.stateVersion = "22.11";
	        imports = [ 
            ../modules/core.nix
    		    # ./nixos-packages.nix
            ../modules/editors/helix.nix
            ../modules/shell/lazygit.nix
    		    # ./modules/common.nix
    		    # ./modules/common-linux.nix
    		    ../modules/shell/fish.nix
          ];
        };
      }
    ];
  };
}
