{
  pkgs,
  user,
  darkmode,
  ...
}:
# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
  system.defaults.dock.autohide = true;

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
  ];

  environment.shells = [pkgs.fish];

  users.users.${user} = {
    shell = pkgs.fish;
    home = /Users/${user};
  };

  home-manager = {
    extraSpecialArgs = {
      user = user;
      darkmode = darkmode;
    }; # Pass flake variable
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {pkgs, ...}: {
      programs.home-manager.enable = true;
      imports = [
        ../../../modules/core.nix
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
