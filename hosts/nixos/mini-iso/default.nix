{
  inputs,
  lib,
  nixpkgs,
  user,
  username,
  darkmode,
  system,
  useColemak,
  ...
}:
lib.nixosSystem {
  specialArgs = {
    inherit inputs user darkmode username system nixpkgs useColemak;
  };
  modules = [
    ../config-common.nix
    ./configuration.nix
    ../networking.nix
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
  ];
}
