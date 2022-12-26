{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    wlr-randr
    nmap
    kitty
    dolphin
    rofi-wayland
    waybar
    which
    wlogout
    plymouth
  ];

  programs.waybar.enable = true;
}
