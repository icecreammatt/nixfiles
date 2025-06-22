{pkgs, ...}: {
  home.enableNixpkgsReleaseCheck = false;
  home.packages = with pkgs; [
    avrdude
    kdePackages.dolphin
    kitty # terminal
    kopia # backup
    kdePackages.filelight # Disk usage statistics
    kiwix # offline wiki
    tea # gitea cli
    godot_4
    godot_4-export-templates-bin
    gdtoolkit_4
    scons # build system for godot
    cmake
    nmap
    nvtopPackages.nvidia
    # add this back once wayland works normcap # OCR powered screen-capture tool to capture information instead of images
    # obsidian
    plymouth
    restic # backup utility
    # rofi-wayland
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
