{pkgs, ...}: {
  home.packages = with pkgs; [
    avrdude
    dolphin
    kitty
    kopia
    nmap
    nvtop-nvidia
    # obsidian
    plymouth
    qmk
    rofi-wayland
    signal-desktop
    syncthing
    syncthingtray
    textsnatcher # Copy Text from Images with ease, Perform OCR operations in seconds
    which
    wlogout
    wlr-randr
  ];

  programs.waybar.enable = true;
}
