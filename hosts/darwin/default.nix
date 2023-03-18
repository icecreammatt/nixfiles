{ lib, inputs, nixpkgs, home-manager, darwin, ... }:

let
  userName = userConfig.user.firstName;
  user = "matt"; # TODO dynamically set this based on architecture
in
{
  # Work laptop config for x86 architecture
  mc-2A3MD6R-MBP = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit user inputs; };
    modules = [
      ./hosts/mc-2A3MD6R-MBP/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = {
          home = {
            stateVersion = "22.11";
          };
          programs.home-manager.enable = true;
        };
      }
    ];
  };

  # Personal laptop config for M1 architecture
  Bebop = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit user inputs; };
    modules = [
      ./hosts/Bebop/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = {
          home = {
            stateVersion = "22.11";
          };
          programs.home-manager.enable = true;
        };
      }
    ];
  };

}
