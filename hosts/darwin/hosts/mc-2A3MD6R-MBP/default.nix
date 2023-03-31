# hosts/mc-2A3MD6R-MBP/default.nix
{ pkgs, ... }:

{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.overlays = [
    (import ../../../../overlay/overlay.nix)
  ];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  system.defaults.dock.autohide = true;

  environment.systemPackages = with pkgs; [ fish ];
  environment.shells = [ pkgs.fish ];

  users.users.mcarrier = {
    shell = pkgs.fish;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mcarrier = { pkgs, ... }: 

  {
    imports = [
      ../../../../modules/common.nix
      ../../../../modules/x86.nix
      ../../../../modules/shell/gitui.nix
      ../../../../modules/shell/tmux.nix
      ../../../../modules/editors/nvim.nix
      ../../../../modules/node16.nix
      # ../../../modules/shell/git.nix
    ];

 
    home.packages = with pkgs; [
      nnn
      worm
      reattach-to-user-namespace
      home-manager
      jdk8
      jenkins
      groovy
      nodePackages_latest.grunt-cli
      nodePackages_latest.bower
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
