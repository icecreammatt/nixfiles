{ lib, inputs, nixpkgs, home-manager, user, ...}:

let
  system = "aarch64-linux";
in
{
  asahi = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    specialArgs = { inherit inputs user; };
    modules = [
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };

}
