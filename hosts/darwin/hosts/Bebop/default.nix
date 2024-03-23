# hosts/Bebop/default.nix
{user, ...}: {
  home-manager.users.${user} = {pkgs, ...}: {
    imports = [
      # ../../../modules/shell/git.nix
      ../../../../modules/common.nix
      ../../../../modules/editors/nvim.nix
      ../../../../modules/rust.nix
      ../../../../modules/shell/gitui.nix
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
