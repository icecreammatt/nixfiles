# hosts/Bebop/default.nix
{ pkgs, ... }:

{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.defaults.dock.autohide = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.matt = { pkgs, ... }: 

  {
    imports = [
      ../../../modules/common.nix
      ../../../modules/shell/fish.nix
      ../../../modules/shell/gitui.nix
      ../../../modules/shell/tmux.nix
      ../../../modules/editors/nvim.nix
      # ../../../modules/shell/git.nix
    ];
 
    home.packages = with pkgs; [
      reattach-to-user-namespace
      home-manager
      # qmk
      # avrdude
      # automake
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
