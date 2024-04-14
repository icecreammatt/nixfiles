# New NixOS install

## Nix setup guide for fresh machines
https://zero-to-nix.com/

## Adding this repo to machine after installing nix

```bash
# Enable Flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Start nix-shell with git
nix-shell -p git
git clone https://github.com/icecreammatt/nixfiles.git
cd nixfiles

# Add new system configuration to nixfiles from install
mkdir -p hosts/nixos/MACHINE_NAME/
cp /etc/nixos/configuration.nix ~/nixfiles/hosts/nixos/MACHINE_NAME/
cp /etc/nixos/hardware-configuration.nix ~/nixfiles/hosts/nixos/MACHINE_NAME/
```

> `nixfiles/hosts/nixos/default.nix`
```nix
# Copy existing vm config and update system to matching architecture
# Add ./MACHINE_NAME/configuration.nix
  nixos = lib.nixosSystem {
    pkgs = import nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
    };
    modules = [
      ./config-common.nix # Do not remove this without adding user directly to machine config or you will be locked out
      ./MACHINE_NAME/configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matt = {
          home.stateVersion = "22.11";
          imports = [
            ../../modules/core.nix
          ];
        };
      }
    ];
  };
```

## Add changes to git so build works

```bash
git add ~/nixfiles/hosts/nixos/MACHINE_NAME

# Rebuild config
sudo nixos-rebuild switch --flake .
```

## Start a new shell window or run fish to update aliases

`fish`

## Update hostname to be unique
> nixfiles/hosts/nixos/MACHINE_NAME/configuration.nix
```nix
networking.hostName = "nixos"; # Define your hostname.

# nixfiles/hosts/nixos/default.nix
nixos = lib.nixosSystem {
...
```

## rebuild to apply changes
```bash
sudo nixos-rebuild switch --flake .
```

## Install nix and home manager
- https://nix.dev/tutorials/install-nix

