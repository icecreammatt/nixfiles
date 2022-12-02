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
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
    config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
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
            imports = [ ./home.nix ];
          };
        }

        hyprland.nixosModules.default {
          programs.hyprland.enable = true; 
        }

          ];
    };
      };
    };
}
