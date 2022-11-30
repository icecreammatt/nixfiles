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

  outputs = inputs @ { self, nixpkgs, home-manager, darwin, hyprland, utils, ... }:
    let
      user = "matt";

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        system = args.system or "aarch64-linux";
        # configuration = import ./home.nix;
        homeDirectory = "/home/matt";
        username = "matt";
        # pkgs = pkgsForSystem system;
     } // args);

    in utils.lib.eachSystem [ "x86_64-linux" ] (system: rec {
      # legacyPackages = pkgsForSystem system;
    })
    {
      darwinConfiguration = (
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager darwin user;
        }
      );

      asahiConfiguration = (
        import ./asahi {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );
    };
}
