{pkgs, ...}: {
  home.packages = with pkgs; [
    avrdude
    dolphin
    kitty
    kopia
    filelight # Disk usage statistics
    godot_4
    godot_4-export-templates
    gdtoolkit_4
    scons
    cmake
    nmap
    nvtopPackages.nvidia
    # add this back once wayland works normcap # OCR powered screen-capture tool to capture information instead of images
    # obsidian
    plymouth
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
