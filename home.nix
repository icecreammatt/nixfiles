{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matt";
  home.homeDirectory = "/Users/matt";

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
    pkgs.icdiff
    pkgs.coreutils
    pkgs.jq
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
	#./tmux.nix
  ];
}
