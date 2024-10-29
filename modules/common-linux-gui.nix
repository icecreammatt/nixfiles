{pkgs, ...}: {
  home.packages = with pkgs; [
    ardour
    hydrogen # drum machine
    reaper # Digital audio workstation
    bmon
    cava
    font-awesome
    freerdp
    hyprpaper
    krakenx
    krita
    lm_sensors
    mission-center # task manager
    nerdfonts
    oculante
    peek
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    xclip # xwindow clipboard
  ];

  imports = [
    ./shell/cava.nix
  ];
}
