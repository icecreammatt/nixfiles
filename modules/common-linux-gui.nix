{pkgs, ...}: {
  home.packages = with pkgs; [
    ardour # audio workstation
    hydrogen # drum machine
    reaper # Digital audio workstation
    font-awesome
    freerdp # remote desktop
    # hyprpaper
    krakenx # AIO driver
    krita # photo editing
    lm_sensors # temp sensors
    mission-center # task manager
    # nerdfonts
    oculante # photo viewer
    peek # gif recording
    vscode
    # vscode-extensions.vadimcn.vscode-lldb
    xclip # xwindow clipboard
  ];
}
