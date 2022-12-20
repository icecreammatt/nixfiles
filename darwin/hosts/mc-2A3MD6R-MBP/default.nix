# hosts/mc-2A3MD6R-MBP/default.nix
{ pkgs, ... }:

{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.defaults.dock.autohide = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mcarrier = { pkgs, ... }: 

  {
    imports = [
      ../../../modules/common.nix
      ../../../modules/x86.nix
      ../../../modules/shell/fish.nix
      ../../../modules/shell/gitui.nix
      ../../../modules/shell/tmux.nix
      ../../../modules/editors/nvim.nix
      # ../../../modules/shell/git.nix
    ];
 
    home.packages = with pkgs; [
      reattach-to-user-namespace
      home-manager
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
