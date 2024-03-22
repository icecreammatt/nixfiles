# hosts/Bebop/default.nix
{
  pkgs,
  inputs,
  system,
  ...
}: {
  users.users.matt = {
    shell = pkgs.fish;
    home = /Users/matt;
  };

  environment = {
    systemPackages = [
      inputs.helix-flake.packages."${system}".helix
    ];
  };

  home-manager.users.matt = {pkgs, ...}: {
    imports = [
      ../../../../modules/options.nix
      ../../../../modules/common.nix
      ../../../../modules/rust.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/editors/nvim.nix
      # ../../../modules/shell/git.nix
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

    home.stateVersion = "22.11";
  };
}
