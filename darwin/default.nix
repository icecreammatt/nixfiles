{ lib, inputs, nixpkgs, home-manager, darwin, config, ...}:

let
  userName = config.user.firstName;
in
{
  work = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit config inputs; };
    modules = [
      # ./home.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit config; };  # Pass flake variable
        home-manager.users.${userName} = import ./home.nix;
      }
    ];
  };

}
