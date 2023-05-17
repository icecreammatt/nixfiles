{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    #nvtop #nonfree
    bitwarden
    blender
    bmon
    cava
    font-awesome
    freerdp
    hyprpaper
    krakenx
    krita
    lm_sensors
    nerdfonts
    peek
    psensor
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    xclip # xwindow clipboard
  ];

  imports = [
    ./shell/cava.nix
  ];
}
