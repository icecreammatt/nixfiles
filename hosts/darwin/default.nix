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
      inherit inputs system darkmode;
      user = userWork;
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
    ];
  };

  # Personal laptop config for M1 architecture
  Bebop = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = {inherit inputs system darkmode user;};
    modules = [
      ../../modules/options.nix
      ./hosts/Bebop/default.nix
      ./hosts/configuration.nix
      home-manager.darwinModules.home-manager
    ];
  };
}
