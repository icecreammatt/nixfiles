{
  lib,
  inputs,
  nixpkgs,
  nixos-hardware,
  home-manager,
  hyprland,
  sops-nix,
  attic,
  user,
  username,
  darkmode,
  ...
}: {
  gaming = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs user darkmode username system nixpkgs;
    };
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./gaming/configuration.nix
      sops-nix.nixosModules.sops
      inputs.xremap-flake.nixosModules.default
      home-manager.nixosModules.home-manager
      hyprland.nixosModules.default
      {
        programs = {
          hyprland.enable = false;
          keyboard-dev.enable = true;
        };
      }
    ];
  };

  mini = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs user darkmode username system nixpkgs;
    };
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./mini/configuration.nix
      attic.nixosModules.atticd
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
    ];
  };

  dockingbay94 = lib.nixosSystem rec {
    system = "aarch64-linux";
    specialArgs = {
      inherit inputs user darkmode username system nixpkgs;
    };
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
    specialArgs = {
      inherit user darkmode;
    };
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
    specialArgs = {
      inherit user darkmode;
    };
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
    useColemak = true;
  };

  # Building notes
  # nix build .#nixosConfigurations.rpiInstaller.config.system.build.sdImage
  # if build fails make sure this is enabled to allow emulation if building from non aarch64-linux.
  # This is very slow 55mins on Ryzen 3900X
  # boot.binfmt.emulatedSystems = ["aarch64-linux"];
  # flash to SD card
  # ensure of= the correct device
  # lsblk
  # plugin sdcard reader
  # lsblk
  # note the new device which is the sd card reader in this case its /dev/sdcX
  # sudo dd if=./result/sd-image/nixos-sd-image-24.05.20240316.c75037b-aarch64-linux.img of=/dev/sdc2 bs=4M status=progres
  rpiInstaller = import ./pi-image/default.nix {
    inherit nixpkgs user lib darkmode inputs username;
    system = "aarch64-linux";
    useColemak = true;
  };
}
