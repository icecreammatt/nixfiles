{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    #nvtop #nonfree
    bmon
    lm_sensors
    psensor
    wezterm
  ];
}
