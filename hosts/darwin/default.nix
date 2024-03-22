{
  inputs,
  home-manager,
  darwin,
  user,
  darkmode,
  ...
}: let
  userWork = "mcarrier"; # override default user
in {
  # Work laptop config for x86 architecture
  MC-DSS-MBPR19 = darwin.lib.darwinSystem rec {
    system = "x86_64-darwin";
    specialArgs = {
      user = userWork;
      inputs = inputs;
      system = system;
      darkmode = darkmode;
    };
    modules = [
      ../../modules/jenkins.nix
      ../../modules/options.nix
      ./hosts/work/default.nix
      ./hosts/configuration.nix
      {
        programs.jenkins-dev.enable = true;
      }
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          user = userWork;
          darkmode = darkmode;
        }; # Pass flake variable
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
  Bebop = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = {
      user = user;
      inputs = inputs;
      system = system;
    };
    modules = [
      ../../modules/options.nix
      ./hosts/Bebop/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          user = user;
          darkmode = darkmode;
        }; # Pass flake variable
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
