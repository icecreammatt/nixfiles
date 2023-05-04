{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    xclip # xwindow clipboard
    bmon

    vscode-extensions.vadimcn.vscode-lldb

    font-awesome
    nerdfonts

    bitwarden
    krita
    blender

    cava
    freerdp
    hyprpaper
    krakenx
    lm_sensors
    psensor
    vscode
    peek
    #nvtop #nonfree
  ];

  imports = [
    ./shell/cava.nix
  ];
}
