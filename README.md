# nixfiles

## Flakes Setup

### Asahi
```bash
nix build .#asahiConfiguration.asahi.activationPackage
./result/activate
```

### Work x86
```bash
nix build .#darwinConfiguration.work.system
```

### Personal M1
```bash
nix build .#darwinConfiguration.personal.system
```

## Setup

### Install nix and home manager
- https://nix.dev/tutorials/install-nix
- https://github.com/nix-community/home-manager#installation
- Clone repo into `~/nixfiles`
- Soft link to config `ln -s ~/nixfiles ~/.config/nixfiles`
- Test build and switch work `home-manager build && home-manager switch`
