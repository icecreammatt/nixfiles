# hosts/mc-2A3MD6R-MBP/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      # ../../../modules/shell/git.nix
      ../../../../modules/common.nix
      ../../../../modules/editors/nvim.nix
      ../../../../modules/node18.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/starship.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/shell/yazi.nix
      ../../../../modules/x86.nix
    ];

    home.packages = with pkgs; [
      jira-cli-go
      # nodePackages_latest.grunt-cli
      # nodePackages_latest.bower
    ];
  };
}
