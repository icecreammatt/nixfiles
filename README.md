# nixfiles

## [Setup new machine](docs/setup.md)

### Asahi
<details>
  <summary>Click me</summary>

```bash
nix build .#asahiConfiguration.asahi.activationPackage
./result/activate
```
</details>

### Work x86
<details>
  <summary>Click me</summary>

```bash
nix build .#darwinConfigurations.mc-2A3MD6R-MBP.system
./result/sw/bin/darwin-rebuild switch --flake . # Use this for the initial build
darwin-rebuild switch --flake . #this will work after initial build
```
</details>

### Personal M1
<details>
  <summary>Click me</summary>

```bash
nix --experimental-features 'flakes nix-command' build .#darwinConfigurations.Bebop.system
nix build .#darwinConfigurations.Bebop.system # the longer version above might be neede for initial install
sudo ./result/activate

./result/sw/bin/darwin-rebuild switch --flake . # Use this for the initial build
darwin-rebuild switch --flake . #this will work after initial build
```

</details>

### NixOS | Raspberry Pi & VM & Gaming PC
<details>
  <summary>Click me</summary>

> Build command will match nix config with machine hostname

```bash
sudo nixos-rebuild switch --flake .
```
</details>

### `nrs` (nix rebuild switch)

Once all systems have been built once the `nrs` alias can be used to `"nix rebuilt switch"` which works on NixOS, Asahi Linux and OSX. No need to memorize separate commands for each environment. The alias defined in the fish config will pick the correct command depending on if running NixOS, Darwin or Asahi.

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

## [OSX Rust Fixes](docs/rust.md)

## Old Package Versions
<details>
  <summary>Click me</summary>
Finding older versions by using commit hash and then convert url into 

- [https://github.com/NixOS/nixpkgs/commit/708dcbce926fdfb40a08ff625148fe11b6fe601d](https://github.com/NixOS/nixpkgs/commit/708dcbce926fdfb40a08ff625148fe11b6fe601d)
- [https://codeload.github.com/NixOS/nixpkgs/tar.gz/708dcbce926fdfb40a08ff625148fe11b6fe601d](https://codeload.github.com/NixOS/nixpkgs/tar.gz/708dcbce926fdfb40a08ff625148fe11b6fe601d)
- This site can also be used to find version info for past releases
  - [https://lazamar.co.uk/nix-versions/](https://lazamar.co.uk/nix-versions/)

</details>
