{
  inputs,
  lib,
  nixpkgs,
  user,
  username,
  darkmode,
  system,
  ...
}:
lib.nixosSystem {
  specialArgs = {
    inherit inputs user darkmode username system nixpkgs;
  };
  modules = [
    ../config-common.nix
    ./configuration.nix
    ../networking.nix
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
  ];
}
