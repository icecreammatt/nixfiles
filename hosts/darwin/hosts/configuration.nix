{ nix, pkgs, ... }:

# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.overlays = [
    (import ../../../overlay/overlay.nix)
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [ fish ];
  environment.shells = [ pkgs.fish ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}