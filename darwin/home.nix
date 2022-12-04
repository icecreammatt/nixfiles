{ pkgs, user, ... }:

{
  imports = [
    ../modules/common.nix
    ../modules/shell/fish.nix
    # ../modules/shell/git.nix
    ../modules/shell/gitui.nix
    ../modules/shell/tmux.nix
    ../modules/editors/nvim.nix
  ];

  home = {
    #username = "${user}";
    #homeDirectory = "/Users/${user}";
    packages = with pkgs; [
      reattach-to-user-namespace
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
