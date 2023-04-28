# hosts/mc-2A3MD6R-MBP/default.nix
{ pkgs, ... }:

{
  system.defaults.dock.autohide = false;

  users.users.mcarrier = {
    shell = pkgs.fish;
  };

  home-manager.users.mcarrier = { pkgs, ... }:
  {
    imports = [
      ../../../../modules/common.nix
      ../../../../modules/keyboard-dev.nix
      ../../../../modules/x86.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/editors/nvim.nix
      # ../../../../modules/node16.nix
      # ../../../modules/shell/git.nix
    ];

    home.packages = with pkgs; [
      nodejs-18_x
      nodePackages.typescript-language-server
      nodePackages.pnpm
      nnn
      worm
      reattach-to-user-namespace
      home-manager
      jdk8
      jenkins
      groovy
      nodePackages_latest.grunt-cli
      nodePackages_latest.bower
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
