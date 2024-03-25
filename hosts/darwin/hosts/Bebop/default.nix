# hosts/Bebop/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      ../../../../modules/rust.nix
      ../../../../modules/shell/tmux.nix
    ];

    home.packages = with pkgs; [
      automake
      avrdude
      hex2color
      lilypond-with-fonts
      nodePackages.pnpm
      nodePackages.typescript-language-server
      nodejs-18_x
      pocketbase
      wezterm
    ];
  };
}
