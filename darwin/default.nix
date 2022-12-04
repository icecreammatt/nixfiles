{ lib, inputs, nixpkgs, home-manager, darwin, userConfig, ... }:

let
  userName = userConfig.user.firstName;
  user = "mcarrier";
in
{
  mc-2A3MD6R-MBP = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit user inputs; };
    modules = [
      #./configuration.nix
      ./hosts/mc-2A3MD6R-MBP/default.nix
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };

}
