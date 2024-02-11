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
  ...
}: let
  user = "matt";
in {
  nixos-vm = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
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

  gaming = lib.nixosSystem {
    # inherit hyprland;

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      system = "x86_64-linux";
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };
    modules = [
      ./gaming/configuration.nix
      ./networking.nix
      sops-nix.nixosModules.sops
      inputs.xremap-flake.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ./gaming/nixos-packages.nix
            ../../modules/common.nix
            ../../modules/common-linux.nix
            ../../modules/common-linux-gui.nix
            ../../modules/rust.nix
            ../../modules/DE/rofi.nix
            # ../../modules/DE/hypr.nix
            # ../../modules/DE/waybar.nix
          ];
        };
      }

      hyprland.nixosModules.default
      {
        programs.hyprland.enable = false;
      }
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
    modules = [
      nixos-hardware.nixosModules.raspberry-pi-4
      ./config-common.nix
      ./networking.nix
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

  mini = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };
    specialArgs = {
      inherit user;
    };
    modules = [
      ../../modules/options.nix
      ./config-common.nix
      ./networking.nix
      ./mini/configuration.nix
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
        home-manager.users."${user}" = {
          home.stateVersion = "23.11";
          imports = [
            ../../modules/options.nix
            ../../modules/shell/starship.nix
            ../../modules/common.nix
            ../../modules/rust.nix
            ../../modules/k8s.nix
          ];
        };
      }
    ];
  };
}
