{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bmon
    qmk
    avrdude

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
  ];
}
