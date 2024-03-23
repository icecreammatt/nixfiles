{
  lib,
  inputs,
  nixpkgs,
  nixos-hardware,
  home-manager,
  hyprland,
  helix-flake,
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
      ./config-common.nix
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
      ./config-common.nix
      ./mini/configuration.nix
      attic.nixosModules.atticd
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
    ];
  };

  dockingbay94 = lib.nixosSystem {
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
      nixos-hardware.nixosModules.raspberry-pi-4
      ./config-common.nix
      ./pi4/configuration.nix
      {
        environment.systemPackages = [
          helix-flake.packages."aarch64-linux".default
        ];
      }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user username darkmode;
          isDark = true;
        };
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ../../modules/core.nix
            # ../../modules/rust.nix
            # ../../modules/k8s.nix
          ];
        };
      }
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
      ./config-common.nix
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
      ./config-common.nix
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

  isoInstaller = lib.nixosSystem rec {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };
    specialArgs = {
      inherit user username darkmode pkgs;
    };
    modules = [
      ../../modules/options.nix
      ./config-common.nix
      ./networking.nix
      ./mini-iso/configuration.nix
      {
        environment.systemPackages = [
          helix-flake.packages."x86_64-linux".default
        ];
      }
      attic.nixosModules.atticd
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user username darkmode;};
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ../../modules/options.nix
            ../../modules/shell/starship.nix
            ../../modules/shell/git.nix
            ../../modules/common.nix
            #../../modules/rust.nix
            #../../modules/k8s.nix
          ];
        };
      }
    ];
  };
}
