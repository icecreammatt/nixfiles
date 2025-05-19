{
  lib,
  inputs,
  nixpkgs,
  nixos-hardware,
  home-manager,
  sops-nix,
  user,
  username,
  darkmode,
  ...
}: {
  gaming = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {inherit inputs user darkmode username system nixpkgs;};
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./gaming/configuration.nix
      sops-nix.nixosModules.sops
      # inputs.xremap-flake.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        programs = {
          keyboard-dev.enable = true;
        };
      }
    ];
  };

  mini = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {inherit inputs user darkmode username system nixpkgs;};
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./mini/configuration.nix
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
    ];
  };

  dockingbay94 = lib.nixosSystem rec {
    system = "aarch64-linux";
    specialArgs = {inherit inputs user darkmode username system nixpkgs;};
    modules = [
      nixos-hardware.nixosModules.raspberry-pi-4
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./pi4/configuration.nix
      home-manager.nixosModules.home-manager
    ];
  };

  nixos-vm = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };
    specialArgs = {inherit user darkmode;};
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./networking.nix
      ./vm/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ../../modules/core.nix
            ../../modules/rust.nix
          ];
        };
      }
    ];
  };

  vm2 = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };
    specialArgs = {inherit user darkmode;};
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./networking.nix
      ./vm2/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ../../modules/core.nix
            ../../modules/common.nix
            ../../modules/rust.nix
          ];
        };
      }
    ];
  };

  isoInstaller = import ./mini-iso/default.nix {
    inherit nixpkgs user lib darkmode inputs username;
    system = "x86_64-linux";
    useColemak = false;
  };
}
