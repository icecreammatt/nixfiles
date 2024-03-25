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
    ../config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
    ./configuration.nix
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
  ];
}
