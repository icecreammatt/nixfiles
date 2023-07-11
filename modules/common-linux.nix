{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bmon
    gping     # ping with graph | problems on darwin
    lm_sensors
    psensor
    # ssm-agent # AWS cli tool ssm-sli for accessing remove instances (only works on linux)
    vlan # User mode programs to enable VLANs on Ethernet devices
    wezterm
  ];
}
