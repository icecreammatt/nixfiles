{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ardour
    # blender # build errors with latest flake.lock
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
    # peek # causing issues in latest flake.lock
    psensor
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    xclip # xwindow clipboard
  ];

  imports = [
    ./shell/cava.nix
  ];
}
