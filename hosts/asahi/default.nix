{ lib, inputs, nixpkgs, home-manager, ... }:

let
  user = "matt";
  userName = "matt";

  pkgs = import nixpkgs {
    # Setup Asahi Architecture
    system = "aarch64-linux";

    # Allow packages like Nvidia Drivers
    config.allowUnfree = true;

    # Import overlays defined in the root directory overlay config
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
            pkgs.cascadia-code  # Fonts
            pkgs.docker
            pkgs.hex2color      # CLI color display
            pkgs.home-manager   # Used for managing files and programs in home directory
            pkgs.nerdfonts      # Fonts
            pkgs.nmap           # Network Debugging tool
            # pkgs.wezterm        # The Best Terminal // Use pacman verion that doesn't crash for Asahi
            pkgs.which          # Determine where processes are
            pkgs.lilypond-with-fonts # Sheet Music
            pkgs.wl-clipboard   # Command-line copy/paste utilities for Wayland
            pkgs.waypipe
          ];
          stateVersion = "23.05";
        };
      }
    ];
  };
}
