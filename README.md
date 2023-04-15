# nixfiles

## New NixOS install

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
      ./config-common.nix
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

### Add changes to git so build works

```bash
git add ~/nixfiles/hosts/nixos/MACHINE_NAME

# Rebuild config
sudo nixos-rebuild switch --flake .
```

### Start a new shell window or run fish to update aliases

`fish`

### Update hostname to be unique
> nixfiles/hosts/nixos/MACHINE_NAME/configuration.nix
```nix
networking.hostName = "nixos"; # Define your hostname.

# nixfiles/hosts/nixos/default.nix
nixos = lib.nixosSystem {
...
```

### rebuild to apply changes
```bash
sudo nixos-rebuild switch --flake .
```

### Install nix and home manager
- https://nix.dev/tutorials/install-nix

### Asahi
```bash
nix build .#asahiConfiguration.asahi.activationPackage
./result/activate
```

### Work x86
```bash
nix build .#darwinConfigurations.mc-2A3MD6R-MBP.system
./result/sw/bin/darwin-rebuild switch --flake . # Use this for the initial build
darwin-rebuild switch --flake . #this will work after initial build
```

### Personal M1
```bash
nix --experimental-features 'flakes nix-command' build .#darwinConfigurations.Bebop.system
nix build .#darwinConfigurations.Bebop.system # the longer version above might be neede for initial install
sudo ./result/activate

./result/sw/bin/darwin-rebuild switch --flake . # Use this for the initial build
darwin-rebuild switch --flake . #this will work after initial build
```

### NixOS | Raspberry Pi & VM & Gaming PC

> Build command will match nix config with machine hostname

```bash
sudo nixos-rebuild switch --flake .
```

## Shoutouts
- https://github.com/MatthiasBenaets/nixos-config
- https://github.com/thexyno/nixos-config
- https://github.com/Robertof/nixos-docker-sd-image-builder.

## Directory Setup

```txt
├── hosts (Computers)
│  ├── asahi (M1 Linux)
│  ├── darwin (MacOS)
│  │  └── hosts
│  │     ├── Bebop
│  │     └── mc-2A3MD6R-MBP
│  └── nixos (NixOS)
│     ├── gaming
│     ├── mini
│     ├── pi4
│     └── vm
├── modules (Programs)
│  ├── DE (Linux Desktop Environments)
│  │  ├── hypr
│  │  ├── rofi
│  │  └── waybar
│  ├── editors
│  │  └── nvim
│  ├── firefox
│  └── shell (CLI tools and dotfiles)
│     ├── bottom
│     ├── broot
│     ├── cava
│     ├── kitty
│     ├── lazygit
│     ├── neofetch
│     ├── scripts
│     ├── wezterm
│     └── xplr
└── overlay (Customizations and Overlays)
   ├── nnn
   └── worm
```