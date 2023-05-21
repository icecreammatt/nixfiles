# Programs to install on most systems

{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # jdt-language-server
    audacity
    awscli2
    bash
    caddy # web server
    clang-tools
    dogdns
    ffmpeg_6-full
    gcc
    gettext
    gh # github cli
    gifsicle # cli gif tool
    gist # github gist uploader
    git-standup # list work done in repo over last day
    gitui # gitui in rust
    go # programming languge
    graph-easy
    gron # json search tool
    hex2color
    hugo # static site generator
    hurl # Command line tool that performs HTTP requests defined in a simple plain text format.
    imagemagickBig
    imgcat # display images in terminal
    lazycli
    lazydocker
    libiconvReal
    lldb
    mdpls
    mediainfo
    mkcert
    morph
    nebula # vpn client/server
    nix-prefetch
    nix-prefetch-git
    nodePackages.bash-language-server # A language server for Bash
    nodePackages.diff2html-cli # Fast Diff to colorized HTML
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages_latest.web-ext # web extension packager
    nodePackages_latest.yaml-language-server
    nss
    nssTools
    oculante
    oha  # HTTP load generator inspired by rakyll/hey with tui animation
    onefetch # git repo summary
    pandoc # document convertions
    pipes-rs
    procs # ps in rust
    python310Packages.python-lsp-server
    python39 # programming languge
    qemu
    s3cmd # s3 cli
    slides
    sumneko-lua-language-server
    t-rec # screenshot
    terminal-colors
    ttyd # share terminal over web
    viu # image viewer
    wiki-tui
    zellij # terminal multiplexer
  ];

  imports = [
    ./core.nix
    # ./rust.nix
    ./k8s.nix
    ./shell/wezterm.nix
  ];

#  imports = [ ./git.nix ] ++ lib.optional (builtins.pathExists ./work.nix) ./work.nix;
}
