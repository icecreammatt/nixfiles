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
    #pkgs.avrdude
    #pkgs.qmk
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

#   programs.neovim.enable = true;
  programs.htop.enable = true;

  imports = [
	./git.nix
	./fish.nix
	./nvim.nix
	./tmux.nix
  ];
}
