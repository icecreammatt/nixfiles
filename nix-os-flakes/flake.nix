{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "matt";
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
	  inherit system;
	  modules = [ 
            ./configuration.nix 

	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.matt = {
	        imports = [ 
		    ./packages.nix
		    ../modules/shell/fish.nix
		    ../modules/shell/tmux.nix
		    ../modules/shell/gitui.nix
		    ../modules/editors/nvim.nix
		    #../modules/shell/git.nix
		];
		home.stateVersion = "22.05";
		home.username = "matt";
		programs.home-manager.enable = true;
	      };
	    }

	    hyprland.nixosModules.default {
	      programs.hyprland.enable = true; 
	    }

          ];
	};
      };

      #hmConfig = {
      #  nixos = home-manager.lib.homeManagerConfiguration {
          #inherit system pkgs;
          #username = "matt";
          #homeDirectory = "/home/matt";
          #stateVersion = "22.05";
          #configuration = {
          #  imports = [
          #    ./home.nix
          #  ];
          #};
      #  };
      #};

    };
}
