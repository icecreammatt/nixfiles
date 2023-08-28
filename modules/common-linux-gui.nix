{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ardour
    reaper    # Digital audio workstation
    # blender # build errors with latest flake.lock
    bmon
    cava
    font-awesome
    freerdp
    hyprpaper
    krakenx
    krita
    lm_sensors
    # mission-center # task manager (needs flake update)
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
