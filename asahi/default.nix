{ lib, inputs, nixpkgs, home-manager, userConfig, ... }:

let
  system = "aarch64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  #user = userConfig.user.firstName;
  #userName = userConfig.firstName;
  user = "matt";
  userName = "matt";
in
{
  asahi = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs user; };
    modules = [
        ../modules/common.nix
        ../modules/shell/fish.nix
        #../modules/shell/git.nix
        ../modules/shell/gitui.nix
        ../modules/shell/tmux.nix
        ../modules/editors/nvim.nix
      {
        home = {
          username = "${userName}";
          homeDirectory = "/home/${userName}";
          packages = [ pkgs.home-manager ];
          stateVersion = "22.11";
        };
      }
    ];
  };
}
