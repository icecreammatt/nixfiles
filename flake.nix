# This file is the entrypoint into all the system configurations

{
  description = "System configuration for NixOS, Mac, Asahi";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, darwin, hyprland, ... }:
    let
      userConfig.user = {
        firstName = "Matt";
        lastName = "Carrier";
        email = "placeholder@example.com";
      };
    in
    {
      # NixOS
      nixosConfigurations.gaming = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # inherit pkgs;
        modules = [
          ./nix-os-flakes/configuration.nix
    	    home-manager.nixosModules.home-manager {
    	      home-manager.useGlobalPkgs = true;
    	      home-manager.useUserPackages = true;
    	      home-manager.users.matt = {
              home.stateVersion = "22.11";
    	        imports = [ 
        		    # ./nixos-packages.nix
        		    # ./modules/common.nix
        		    # ./modules/common-linux.nix
        		    ./modules/shell/fish.nix
              ];
            };
          }
        ];
      };

      # M1 Mac + Linux config
      asahiConfiguration = (
        import ./asahi {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager userConfig;
        }
      );

      # Mac x86_64/aarch64 configs
      darwinConfigurations = (
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager darwin userConfig;
        }
      );

  };
}
