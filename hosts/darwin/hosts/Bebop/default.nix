# hosts/Bebop/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      ../../../../modules/rust.nix
      ../../../../modules/shell/tmux.nix
    ];

    home.packages = with pkgs; [
      atac
      audacity
      automake
      awscli2
      avrdude
      doctl
      drill
      hex2color
      httpie
      hoppscotch
      jetbrains.idea-community
      jdk22
      lilypond-with-fonts
      nodePackages.pnpm
      nodePackages.typescript-language-server
      nodejs-18_x
      opentofu
      pocketbase
      redis
      wezterm
    ];
  };
}
