{ lib, inputs, nixpkgs, home-manager, user, ... }:

let
  system = "aarch64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
{
  asahi = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs user; };
    modules = [
      # ../modules/common.nix
      # ./home.nix
      {
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          packages = [ pkgs.home-manager ];
          stateVersion = "22.05";
        };
      }
    ];
  };
}
