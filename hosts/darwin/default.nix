{
  inputs,
  home-manager,
  darwin,
  user,
  ...
}: let
  userWork = "mcarrier"; # override default user
in {
  # Work laptop config for x86 architecture
  MC-DSS-MBPR19 = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = {user = userWork inputs;};
    modules = [
      ../../modules/options.nix
      ./hosts/work/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {user = userWork;}; # Pass flake variable
        home-manager.users.${userWork} = {
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
    specialArgs = {user = user inputs;};
    modules = [
      ../../modules/options.nix
      ./hosts/Bebop/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {user = user;}; # Pass flake variable
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
