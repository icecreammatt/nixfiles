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
  # M1 Macbook Pro + Asahi Linux Configuration
  asahi = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs user; };
    modules = [
        ../modules/common.nix
        ../modules/shell/fish.nix
        ../modules/shell/gitui.nix
        ../modules/shell/tmux.nix
        ../modules/editors/nvim.nix
        ../modules/DE/hypr.nix
        ../modules/DE/waybar.nix
        ../modules/DE/rofi.nix
        ../modules/shell/kitty.nix
        #../modules/shell/git.nix
      {
        home = {
          username = "${userName}";
          homeDirectory = "/home/${userName}";
          packages = [ 
            pkgs.home-manager 
            pkgs.avrdude 
            pkgs.qmk
            pkgs.wlr-randr
            pkgs.nmap
            pkgs.dolphin
            pkgs.rofi-wayland
            pkgs.waybar
            pkgs.which
            # signal-desktop
          ];
          stateVersion = "22.11";
        };
      }
    ];
  };
}
