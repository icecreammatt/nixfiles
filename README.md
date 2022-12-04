# nixfiles

## Flakes Setup

### Install nix and home manager
- https://nix.dev/tutorials/install-nix
- Clone repo into `~/nixfiles`

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
./result/sw/bin/darwin-rebuild switch --flake . # Use this for the initial build
darwin-rebuild switch --flake . #this will work after initial build
```

## Shoutouts
- https://github.com/MatthiasBenaets/nixos-config
- https://github.com/thexyno/nixos-config
