{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
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
    oculante
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
