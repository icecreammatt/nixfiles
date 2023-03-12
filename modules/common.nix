# Programs to install on all systems
# Modern Unix https://github.com/ibraheemdev/modern-unix

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # uutils-coreutils - enable once all is ported
    # wezterm
    argocd
    awscli
    bandwhich
    bash
    broot
    caddy
    choose
    clang-tools
    coreutils
    curlie
    dogdns
    du-dust
    duf
    ffmpeg
    gcc
    gettext
    gh
    gifsicle
    gist
    git-standup
    gitui
    go
    gping
    gron
    httpie
    hugo
    imagemagick
    imgcat
    jq
    k9s
    kind
    kitty
    kubernetes-helm-wrapped
    lazycli
    lazydocker
    libiconvReal
    lldb
    mdcat
    mediainfo
    minikube
    mkcert
    neofetch
    nix-prefetch
    nmap
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    nss
    nssTools
    onefetch
    pandoc
    pipes-rs
    procs
    python39
    rnix-lsp
    rsync
    rust-analyzer
    rust-script
    rustup
    s3cmd
    sumneko-lua-language-server
    t-rec
    terminal-colors
    tig
    ttyd
    viu
    xclip
    xh
    yq
    zellij
  ];

  imports = [
    ./core.nix
    ./rust.nix
    ./shell/cava.nix
    ./shell/kitty.nix
    ./shell/wezterm.nix
  ];

#  imports = [ ./git.nix ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
