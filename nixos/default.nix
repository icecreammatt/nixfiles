{ lib, inputs, nixpkgs, home-manager, userConfig, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
  user = "matt";
in
{
  nixos = lib.nixosSystem {
    inherit system;
    inherit pkgs;
  };
}
