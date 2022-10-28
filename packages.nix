{ pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep
    pkgs.bat
    pkgs.fd
    pkgs.exa
    pkgs.fzf
    pkgs.coreutils
    pkgs.jq
    pkgs.yq
    pkgs.tig
    pkgs.gron
    pkgs.gh
    pkgs.delta
    pkgs.wget
    pkgs.tree
    pkgs.curl
    pkgs.bash
    pkgs.rsync
    pkgs.tig
    pkgs.git
    pkgs.ffmpeg
    pkgs.coreutils
    pkgs.mkcert
    pkgs.git-standup
    pkgs.imagemagick
    pkgs.gifsicle
    pkgs.gist
    pkgs.s3cmd
    pkgs.reattach-to-user-namespace
    pkgs.nnn
    pkgs.navi
    pkgs.gitui
    pkgs.nss
    pkgs.nssTools
    pkgs.tldr
    pkgs.viu
    pkgs.t-rec
    pkgs.neofetch
    pkgs.htop
    pkgs.bottom
    pkgs.rnix-lsp
    pkgs.time
    pkgs.gettext
    pkgs.hugo
    pkgs.ttyd
    pkgs.go
    pkgs.caddy
    pkgs.sumneko-lua-language-server
    pkgs.nodePackages.typescript-language-server
    pkgs.nodejs-16_x
    pkgs.nodePackages.pnpm
    # pkgs.svelte-language-server
    #pkgs.peek #- issue on darwin
    #pkgs.avrdude #- issue on m1
    #pkgs.qmk #- issue on m1
  ];

  imports = [
    ./git.nix
    ./fish.nix
    ./nvim.nix
    ./tmux.nix
    ./gitui.nix
  ];
}
