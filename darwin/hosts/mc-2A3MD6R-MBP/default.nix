# hosts/mc-2A3MD6R-MBP/default.nix
{ pkgs, ... }:

let
    system = "x86_64-darwin"; # Todo see how to pass this through from parent
    # version = "16.13.1"; <-- this is for refence for the build sha below
    pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
      sha256 = "13s8g6p0gzpa1q6mwc2fj2v451dsars67m4mwciimgfwhdlxx0bk";
    }) { inherit system; };

    node16 = pkgs.nodejs;
in
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
      node16
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
