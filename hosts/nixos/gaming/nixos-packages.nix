{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    avrdude
    dolphin
    kitty
    nmap
    nvtop-nvidia
    obsidian
    plymouth
    qmk
    rofi-wayland
    signal-desktop
    syncthing
    syncthingtray
    which
    wlogout
    wlr-randr
  ];

  programs.waybar.enable = true;
}
