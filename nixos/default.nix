{ lib, inputs, nixpkgs, home-manager, userConfig, ... }:

let
  system = "aarch64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
  user = "matt";
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
