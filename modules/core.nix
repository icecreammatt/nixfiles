# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{ pkgs, lib, isDark, ... }:

let
  # Override to inject light vs dark theme setting
  helix_custom = import ./editors/helix.nix { inherit isDark; };
  
  hello = import ./bin/hello.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    # uutils-coreutils - enable once all is ported
    # wezterm
    hello
    bandwhich # network monitor
    bat       # cat alternative
    bind      # DNS utils
    bottom    # btm top alternative
    choose    # awk like tool
    coreutils
    curl
    delta     # diff dool
    direnv    # auto switch to using nix flake on directory nav
    du-dust   # space visualizer
    duf       # du alternative
    eza       # ls alternative
    fd        # find alternative
    fishPlugins.bass  # Fish function making it easy to use utilities written for Bash in Fish shell
    fzf
    git
    helix
    htop
    jq
    lazygit
    lsof      # list open fils and connections
    mdcat     # cat for markdown files
    mprocs    # task runner
    neofetch  # os summary
    nix-tree  # tree view of nix flake dependencies
    nmap      # network scanner utility
    nnn       # cli explorer
    ranger    # cli explorer
    ripgrep
    rnix-lsp  # lsp for nix files used by helix
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
  ];

  imports = [
    ./bin.nix
    ./shell/bottom.nix
    ./shell/broot.nix
    ./shell/fish.nix
    ./shell/lazygit.nix
    ./shell/mprocs.nix
    ./shell/neofetch.nix
    ./shell/scripts.nix
    ./shell/xplr.nix
    helix_custom
];

}