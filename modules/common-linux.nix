{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wezterm
    bmon
    lm_sensors
    psensor
    #nvtop #nonfree
  ];
}
