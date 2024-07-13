# hosts/Bebop/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      ../../../../modules/rust.nix
      ../../../../modules/shell/tmux.nix
    ];

    home.packages = with pkgs; [
      audacity
      automake
      awscli2
      avrdude
      doctl
      hex2color
      lilypond-with-fonts
      nodePackages.pnpm
      nodePackages.typescript-language-server
      nodejs-18_x
      opentofu
      pocketbase
      wezterm
    ];
  };
}
