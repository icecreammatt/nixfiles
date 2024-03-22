{
  pkgs,
  user,
  ...
}:
# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
  system.defaults.dock.autohide = true;

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

  environment.systemPackages = with pkgs; [fish];
  environment.shells = [pkgs.fish];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {pkgs, ...}: {
      programs.home-manager.enable = true;
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
