{
  pkgs,
  darkmode,
  ...
}: let
  # Override to pass darkmode settings
  wezterm_custom = import ./shell/wezterm.nix {inherit darkmode;};
in {
  home.packages = with pkgs; [
    atuin
    # audacity
    # awscli2
    bmon # Network bandwidth monitor
    bashInteractive
    caddy # web server
    # clang-tools
    dive # A tool for exploring each layer in a docker image
    dogdns # Command-line DNS client
    # ffmpeg_6-full
    gcc
    gettext
    gh # github cli
    # gifsicle                          # cli gif tool
    glow # Render markdown on the CLI, with pizzazz
    gist # github gist uploader
    git-standup # list work done in repo over last day
    git-cliff # A highly customizable Changelog Generator that follows Conventional Commit specifications
    gitui # gitui in rust
    go # programming languge
    graph-easy # Render/convert graphs in/from various formats
    gron # json search tool
    # hex2color # Hex code color preview
    hexyl # Hex Viewer
    hugo # static site generator
    # hurl # Command line tool that performs HTTP requests defined in a simple plain text format.
    imagemagickBig
    imgcat # display images in terminal
    jujutsu # vcs
    lazycli
    lazydocker
    libiconvReal
    # lldb
    # mdpls # markdown language server
    mediainfo # display media info from mpeg file
    melt # Backup and restore Ed25519 SSH keys with seed words
    mkcert
    morph # A NixOS host manager written in Golang
    mtr # A network diagnostics tool
    nix-inspect # A Rust package for inspecting Nix expressions
    nebula # vpn client/server
    nix-prefetch
    nix-prefetch-git
    # nodePackages.bash-language-server # A language server for Bash
    # nodePackages.diff2html-cli        # Fast Diff to colorized HTML
    # nodePackages_latest.web-ext       # web extension packager
    # nodePackages_latest.yaml-language-server
    # nodePackages.svelte-language-server
    # nodePackages.vscode-langservers-extracted
    nss
    nh # Yet another nix cli helper
    nvd # Nix/NixOS package version diff tool
    nssTools
    # oha # HTTP load generator inspired by rakyll/hey with tui animation
    onefetch # git repo summary
    openssl # A cryptographic library that implements the SSL and TLS protocols
    # pandoc                          # document convertions
    pipes-rs
    procs # ps in rust
    qemu
    # python310Packages.python-lsp-server
    # python39                        # programming languge
    qrencode # C library for encoding data in a QR Code symbol
    skopeo # A command line utility for various operations on container images and image repositories
    s3cmd # s3 cli
    slides
    sqlite
    ssh-to-age # Convert ssh private keys in ed25519 format to age keys
    # sumneko-lua-language-server
    tailspin # A log file highlighter
    terminal-colors
    t-rec # screenshot
    ttyd # share terminal over web
    # uxplay # AirPlay Unix mirroring server
    viu # image viewer
    # vlan                              # User mode programs to enable VLANs on Ethernet devices
    # watchman # Watches files and takes action when they change
    wiki-tui # A simple and easy to use Wikipedia Text User Interface
    # zellij # terminal multiplexer
    zk # A zettelkasten plain text note-taking assistant
  ];

  imports = [
    #core_override
    wezterm_custom
    # ./shell/wezterm.nix
    ./k8s.nix
  ];
}
