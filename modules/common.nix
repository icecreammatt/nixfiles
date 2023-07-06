{ pkgs, lib, ... }:

let
  # Enable dark mode theme
  isDark = true;

  # Override to pass darkmode settings
  wezterm_custom = import ./shell/wezterm.nix { inherit isDark; };
  core_override = import ./core.nix { inherit pkgs lib isDark; };
in
{
  home.packages = with pkgs; [
    audacity
    awscli2
    bash
    caddy                             # web server
    clang-tools
    dogdns                            # Command-line DNS client
    ffmpeg_6-full
    gcc
    gettext
    gh                                # github cli
    # gifsicle                          # cli gif tool
    gist                              # github gist uploader
    git-standup                       # list work done in repo over last day
    gitui                             # gitui in rust
    go                                # programming languge
    graph-easy                        # Render/convert graphs in/from various formats
    gron                              # json search tool
    hex2color                         # Hex code color preview
    hexyl                             # Hex Viewer
    hugo                              # static site generator
    hurl                              # Command line tool that performs HTTP requests defined in a simple plain text format.
    imagemagickBig
    imgcat                            # display images in terminal
                                      # jdt-language-server
    lazycli
    lazydocker
    libiconvReal
    lldb
    mdpls                             # markdown language server
    mediainfo                         # display media info from mpeg file
    mkcert
    morph                             # A NixOS host manager written in Golang
    mtr                               # A network diagnostics tool
    nebula                            # vpn client/server
    nix-prefetch
    nix-prefetch-git
    nodePackages.bash-language-server # A language server for Bash
    nodePackages.diff2html-cli        # Fast Diff to colorized HTML
    nodePackages_latest.web-ext       # web extension packager
    nodePackages_latest.yaml-language-server
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    nss
    nssTools
    oha                               # HTTP load generator inspired by rakyll/hey with tui animation
    onefetch                          # git repo summary
    openssl                           # A cryptographic library that implements the SSL and TLS protocols
    pandoc                            # document convertions
    pipes-rs
    procs                             # ps in rust
    python310Packages.python-lsp-server
    python39                          # programming languge
    qemu
    s3cmd                             # s3 cli
    slides
    ssh-to-age                        # Convert ssh private keys in ed25519 format to age keys
    sumneko-lua-language-server
    terminal-colors
    t-rec                             # screenshot
    ttyd                              # share terminal over web
    uxplay                            # AirPlay Unix mirroring server
    viu                               # image viewer
    wiki-tui                          # A simple and easy to use Wikipedia Text User Interface
    zellij                            # terminal multiplexer
    zk                                # A zettelkasten plain text note-taking assistant
  ];

  imports = [
    core_override
    # ./core.nix
    wezterm_custom
    # ./shell/wezterm.nix
    ./k8s.nix
  ];
}
