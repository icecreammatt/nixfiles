# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
    onefetch
    pipes-rs
    terminal-colors
    gcc
    rustup
    ripgrep
    skim
    ranger
    bat
    fd
    exa
    broot
    choose
    curlie
    dogdns
    du-dust
    duf
    fd
    fzf
    gping
    httpie
    procs
    xh
    zoxide
    coreutils
    jq
    yq
    tig
    gron
    gh
    python
    python39
    bandwhich
    delta
    wget
    tree
    curl
    bash
    rsync
    tig
    git
    ffmpeg
    coreutils
    mkcert
    git-standup
    imagemagick
    gifsicle
    gist
    s3cmd
    awscli
    nnn
    gitui
    nss
    nssTools
    tldr
    viu
    t-rec
    neofetch
    htop
    bottom
    rnix-lsp
    time
    gettext
    hugo
    ttyd
    go
    xclip
    caddy
    sumneko-lua-language-server
    lazydocker
    lazygit
    lazycli
    # svelte-language-server
    #nvtop #nonfree
  ];

  imports = [
    ./shell/cava.nix
    ./shell/neofetch.nix
    ./shell/bottom.nix
    ./shell/kitty.nix
  ];

#  imports = [ ./git.nix ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
