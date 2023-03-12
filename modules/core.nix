# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # uutils-coreutils - enable once all is ported
    bandwhich # network monitor
    bat # cat alternative
    bottom # btm top alternative
    broot
    coreutils
    curl
    delta # diff dool
    du-dust # space visualizer
    duf  # du alternative
    exa  # ls alternative
    fd   # find alternative
    fzf
    git
    gping # ping with graph
    helix
    htop
    jq
    lazygit
    neofetch # os summary
    mdcat # cat for markdown files
    nmap # network scanner utility
    nnn    # cli explorer
    ranger # cli explorer
    ripgrep
    rsync
    skim   # fzf in rust
    time
    tldr
    tree
    wget
    xh # http request viewer
    xplr   # cli explorer
    yq # cli yaml parser
    zoxide # z shortcut tool
  ];

  imports = [
    ./editors/helix.nix
    ./shell/bottom.nix
    ./shell/fish.nix
    ./shell/lazygit.nix
    ./shell/neofetch.nix
    ./shell/xplr.nix
  ];

}