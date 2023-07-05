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
        # ../../modules/common-linux-gui.nix
        ../../modules/shell/gitui.nix
        # ../../modules/shell/tmux.nix
        # ../../modules/editors/nvim.nix
        # ../../modules/shell/kitty.nix
        ../../modules/rust.nix
        ../../modules/keyboard-dev.nix
        # ../../modules/DE/hypr.nix
        # ../../modules/DE/waybar.nix
        # ../../modules/DE/rofi.nix
        #../../modules/shell/git.nix
      {
        home = {
          username = "${userName}";
          homeDirectory = "/home/${userName}";
          packages = with pkgs; [ 
            # pkgs.ardour
            pkgs.cascadia-code
            # pkgs.dolphin
            pkgs.hex2color
            pkgs.home-manager 
            pkgs.nerdfonts
            pkgs.nmap
            pkgs.wezterm
            pkgs.which
            # pkgs.rofi-wayland
            # pkgs.waybar
            # pkgs.wlr-randr
            # signal-desktop
          ];
          stateVersion = "22.11";
        };
      }
    ];
  };
}
