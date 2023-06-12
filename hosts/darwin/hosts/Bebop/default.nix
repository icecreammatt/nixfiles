# hosts/Bebop/default.nix
{ pkgs, ... }:

{
  system.defaults.dock.autohide = true;

  users.users.matt = {
    shell = pkgs.fish;
  };

  home-manager.users.matt = { pkgs, ... }:
  {
    imports = [
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
      home-manager
      lilypond-with-fonts
      nnn
      nodePackages.pnpm
      nodePackages.typescript-language-server
      nodejs-18_x
      pocketbase
      reattach-to-user-namespace
      wezterm
      worm
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
