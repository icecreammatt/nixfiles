# hosts/mc-2A3MD6R-MBP/default.nix
{ pkgs, ... }:

{
  system.defaults.dock.autohide = false;

  users.users.mcarrier = {
    shell = pkgs.fish;
    home = /Users/mcarrier;
  };

  home-manager.users.mcarrier = { pkgs, ... }:
  {
    imports = [
      ../../../../modules/common.nix
      # ../../../../modules/keyboard-dev.nix
      ../../../../modules/x86.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/editors/nvim.nix
      ../../../../modules/node18.nix
      # ../../../modules/shell/git.nix
    ];

    home.packages = with pkgs; [
      nnn
      worm
      reattach-to-user-namespace
      home-manager
      jdk8
      jenkins
      jenkins-job-builder
      groovy
      jira-cli-go
      # nodePackages_latest.grunt-cli
      # nodePackages_latest.bower
    ];

    home.stateVersion = "22.11";
  };

}
