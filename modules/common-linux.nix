{pkgs, ...}: {
  home.packages = with pkgs; [
    filebrowser
    bmon # bandwidth monitor
    cava # audio visualizer
    wl-clipboard # clipboard util for wayland
    jless # A command-line pager for JSON data
    gping # ping with graph | problems on darwin
    lm_sensors
    # ssm-agent # AWS cli tool ssm-sli for accessing remove instances (only works on linux)
    vlan # User mode programs to enable VLANs on Ethernet devices
    wezterm
  ];

  imports = [
    ./shell/cava.nix
  ];
}
