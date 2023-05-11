# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
              # uutils-coreutils - enable once all is ported
    rnix-lsp  # lsp for nix files used by helix
    nix-tree  # tree view of nix flake dependencies
    direnv    # auto switch to using nix flake on directory nav
    bandwhich # network monitor
    bat       # cat alternative
    bottom    # btm top alternative
    coreutils
    curl
    choose    # awk like tool
    delta     # diff dool
    du-dust   # space visualizer
    duf       # du alternative
    exa       # ls alternative
    fd        # find alternative
    fishPlugins.bass  # Fish function making it easy to use utilities written for Bash in Fish shell
    fzf
    git
    gping     # ping with graph
    helix
    htop
    jq
    lazygit
    lsof      # list open fils and connections
    neofetch  # os summary
    mdcat     # cat for markdown files
    mprocs    # task runner
    nmap      # network scanner utility
    nnn       # cli explorer
    ranger    # cli explorer
    ripgrep
    rsync
    sad       # find and replace for terminal
    sd        # like sed but nicer shorthand syntax
    skim      # fzf in rust
    time
    tldr
    tree
    unzip
    wget
    xh        # http request viewer
    xplr      # cli explorer
    yq        # cli yaml parser
    zoxide    # z shortcut tool
    wezterm
  ];

  imports = [
    ./editors/helix.nix
    ./shell/bottom.nix
    ./shell/broot.nix
    ./shell/fish.nix
    ./shell/lazygit.nix
    ./shell/neofetch.nix
    ./shell/xplr.nix
    ./shell/scripts.nix
  ];

}