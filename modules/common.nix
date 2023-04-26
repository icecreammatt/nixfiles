# Programs to install on most systems

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nix-prefetch-git
    python310Packages.python-lsp-server
    imagemagickBig
    audacity
    wezterm
    qemu
    nodePackages_latest.web-ext # web extension packager
    # jdt-language-server
    nodePackages_latest.yaml-language-server
    awscli2
    bash
    caddy # web server
    clang-tools
    dogdns
    ffmpeg
    gcc
    gettext
    gh # github cli
    gifsicle # cli gif tool
    gist # github gist uploader
    git-standup # list work done in repo over last day
    gitui # gitui in rust
    go # programming languge
    gron # json search tool
    hugo # static site generator
    imgcat # display images in terminal
    lazycli
    lazydocker
    libiconvReal
    lldb
    mediainfo
    mkcert
    morph
    nebula # vpn client/server
    nix-prefetch
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    nss
    nssTools
    onefetch # git repo summary
    pandoc # document convertions
    pipes-rs
    procs # ps in rust
    python39 # programming languge
    s3cmd # s3 cli
    sumneko-lua-language-server
    t-rec # screenshot
    terminal-colors
    ttyd # share terminal over web
    viu # image viewer
    zellij # terminal multiplexer
  ];

  imports = [
    ./core.nix
    ./rust.nix
    ./k8s.nix
    ./shell/wezterm.nix
  ];

#  imports = [ ./git.nix ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
