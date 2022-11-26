{ config, pkgs, ... }:

{
  home.username = "matt";
  #home.homeDirectory = /home/matt;
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
  ];
}
