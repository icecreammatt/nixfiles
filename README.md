# nixfiles

## Flakes Setup

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

## Setup

### Install nix and home manager
- https://nix.dev/tutorials/install-nix
- https://github.com/nix-community/home-manager#installation
- Clone repo into `~/nixfiles`
- Soft link to config `ln -s ~/nixfiles ~/.config/nixfiles`
- Test build and switch work `home-manager build && home-manager switch`
