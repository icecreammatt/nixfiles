{
  pkgs,
  user,
  darkmode,
  inputs,
  ...
}:
# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
  system.defaults.dock.autohide = false;

  system.stateVersion = 5;
  ids.gids.nixbld = 30000;

  imports = [
    ../../../modules/options.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # post-build-hook = $HOME/test.sh

  # home.file."test.sh".source = ''
  #   #!/bin/bash

  #   echo "===== TESTING ====="
  #   touch ~/Desktop/worked.txt
  # '';

  nixpkgs.overlays = [
    (import ../../../overlay/overlay.nix)
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [
    fish
    inputs.helix-flake.packages."${system}".helix
    # inputs.toolong.packages."${system}".toolong
  ];

  environment.shells = [pkgs.fish];

  users.users.${user} = {
    shell = pkgs.fish;
    home = /Users/${user};
  };

  home-manager = {
    extraSpecialArgs = {inherit user darkmode;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {pkgs, ...}: {
      programs.home-manager.enable = true;
      imports = [
        ../../../modules/common.nix
        ../../../modules/core.nix
        ../../../modules/editors/nvim.nix
        ../../../modules/shell/starship.nix
        ../../../modules/shell/tmux.nix
        ../../../modules/shell/yazi.nix
      ];
      home = {
        stateVersion = "22.11";
        packages = with pkgs; [
          home-manager
          reattach-to-user-namespace
        ];
      };
    };
  };
}
