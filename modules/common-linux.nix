{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # ssm-agent # AWS cli tool ssm-sli for accessing remove instances (only works on linux)
    bmon
    lm_sensors
    psensor
    wezterm
  ];
}
