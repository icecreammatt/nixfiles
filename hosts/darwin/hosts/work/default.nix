# hosts/mc-2A3MD6R-MBP/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      ../../../../modules/node18.nix # 18.15.0
    ];

    home.packages = with pkgs; [
      jira-cli-go
      # nodePackages_latest.grunt-cli
      # nodePackages_latest.bower
    ];
  };
}
