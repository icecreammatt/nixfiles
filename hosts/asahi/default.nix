{ lib, inputs, nixpkgs, home-manager, ... }:

let
  user = "matt";
  userName = "matt";
  pkgs = import nixpkgs {
    system = "aarch64-linux";
    config.allowUnfree = true;
    overlays = [ 
      (import ../../overlay/overlay.nix)
    ]; 
  };
in
{
  # M1 Macbook Pro + Asahi Linux Configuration
  asahi = home-manager.lib.homeManagerConfiguration {

    # This is duplicated here for home manager
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [ 
        (import ../../overlay/overlay.nix)
      ]; 
    };

    extraSpecialArgs = { inherit inputs user pkgs; };
    modules = [
        ../../modules/common.nix
        ../../modules/common-linux-gui.nix
        ../../modules/shell/gitui.nix
        ../../modules/rust.nix
        ../../modules/keyboard-dev.nix
      {
        home = {
          username = "${userName}";
          homeDirectory = "/home/${userName}";
          packages = [ 
            pkgs.cascadia-code
            pkgs.hex2color
            pkgs.home-manager 
            pkgs.nerdfonts
            pkgs.nmap
            pkgs.wezterm
            pkgs.which
          ];
          stateVersion = "22.11";
        };
      }
    ];
  };
}
