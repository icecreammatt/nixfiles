{  pkgs, lib, ... }:


{
  home.packages = with pkgs; [
    ripgrep
    bat
    fd
    exa
    fzf
    coreutils
    jq
    yq
    tig
    gron
    gh
    python
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
    nodePackages.typescript-language-server
    nodejs-16_x
    nodePackages.pnpm
    #reattach-to-user-namespace
    # svelte-language-server
    #peek #- issue on darwin
    #avrdude #- issue on m1
    #qmk #- issue on m1
  ];

#  imports = [
#    ./git.nix
#    ./fish.nix
#    ./nvim.nix
#    ./tmux.nix
#    ./gitui.nix
#  ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
