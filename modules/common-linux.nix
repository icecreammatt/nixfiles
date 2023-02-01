{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bmon
    qmk
    avrdude

    vscode-extensions.vadimcn.vscode-lldb

    font-awesome
    nerdfonts

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
}
