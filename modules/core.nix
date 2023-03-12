# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bat
    bottom
    curl
    delta
    exa
    fd
    fzf
    git
    helix
    htop
    lazygit
    nnn
    ranger
    ripgrep
    skim
    time
    tldr
    tree
    wget
    xplr
    zoxide
  ];

  imports = [
    ./editors/helix.nix
    ./shell/bottom.nix
    ./shell/lazygit.nix
    ./shell/neofetch.nix
    ./shell/xplr.nix
  ];

}