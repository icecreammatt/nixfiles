# nixfiles

## [Setup new machine](docs/setup.md)

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

## OSX Rust Fixes

> Softlink these to `~/bin` to fix rust build errors

`~/bin/fix-rust` will do the following:

```
cc -> /usr/bin/cc*
g++ -> /usr/bin/g++*
gcc -> /usr/bin/gcc*
ld -> /usr/bin/ld*
lldb -> /usr/bin/lldb*
llvm-g++ -> /usr/bin/llvm-g++*
llvm-gcc -> /usr/bin/llvm-gcc*
```

---
Finding older versions by using commit hash and then convert url into 
https://github.com/NixOS/nixpkgs/commit/708dcbce926fdfb40a08ff625148fe11b6fe601d

https://codeload.github.com/NixOS/nixpkgs/tar.gz/708dcbce926fdfb40a08ff625148fe11b6fe601d
