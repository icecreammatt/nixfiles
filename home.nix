{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = (builtins.fromJSON(builtins.readFile ./config.json)).username;
  home.homeDirectory = (builtins.fromJSON(builtins.readFile ./config.json)).homedir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.ripgrep
    pkgs.bat
    pkgs.fd
    pkgs.exa
    pkgs.fzf
    pkgs.coreutils
    pkgs.jq
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
    pkgs.tldr
    pkgs.viu
    pkgs.t-rec
    pkgs.neofetch
    pkgs.htop
    pkgs.rnix-lsp
    pkgs.sumneko-lua-language-server
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
