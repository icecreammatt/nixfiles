# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    helix
    kind
    minikube
    kubernetes-helm-wrapped
    k9s
    argocd
    nix-prefetch
    pandoc
    clang-tools
    lldb
    kitty
    onefetch
    nmap
    zellij
    pipes-rs
    terminal-colors
    gcc
    rustup
    rust-script
    rust-analyzer
    libiconvReal
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
    jq
    yq
    tig
    gron
    gh
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
    mediainfo
    coreutils
    # uutils-coreutils - enable once all is ported
    mkcert
    git-standup
    imagemagick
    gifsicle
    gist
    s3cmd
    mdcat
    imgcat
    # wezterm
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
    xplr
    nodePackages.vscode-langservers-extracted
    nodePackages.svelte-language-server
  ];

  imports = [
    ./shell/cava.nix
    ./shell/neofetch.nix
    ./shell/bottom.nix
    ./shell/kitty.nix
    ./shell/wezterm.nix
    ./shell/xplr.nix
    ./shell/lazygit.nix
    ./editors/helix.nix
  ];

#  imports = [ ./git.nix ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
