# hosts/Bebop/default.nix
{ pkgs, ... }:

{
  system.defaults.dock.autohide = true;

  users.users.matt = {
    shell = pkgs.fish;
  };

  home-manager.users.matt = { pkgs, ... }:
  {
    imports = [
      ../../../../modules/common.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/editors/nvim.nix
      # ../../../modules/shell/git.nix
    ];
 
    home.packages = with pkgs; [
      nnn
      worm
      reattach-to-user-namespace
      home-manager
      automake
      avrdude
      nodejs-18_x
      #qmk # still not working on M1 with OSX (works on M1 with Linux though)
    ];

    home.stateVersion = "22.11";
  };

  #homebrew = {
  #  enable = true;
  #  autoUpdate = true;
  # updates homebrew packages on activation,
  # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
  #  casks = [
  #    "iina"
  #  ];
  #};

}
