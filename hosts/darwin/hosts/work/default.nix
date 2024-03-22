# hosts/mc-2A3MD6R-MBP/default.nix
{pkgs, inputs, system, ...}: {
  system.defaults.dock.autohide = false;

  users.users.mcarrier = {
    shell = pkgs.fish;
    home = /Users/mcarrier;
  };

  environment = {
    systemPackages = [
      inputs.helix-flake.packages."${system}".helix
    ];
  };

  home-manager.users.mcarrier = {pkgs, ...}: {
    imports = [
      ../../../../modules/shell/yazi.nix
      ../../../../modules/options.nix
      ../../../../modules/common.nix
      ../../../../modules/shell/starship.nix
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
      jira-cli-go
      # nodePackages_latest.grunt-cli
      # nodePackages_latest.bower
    ];

    home.stateVersion = "22.11";
  };
}
