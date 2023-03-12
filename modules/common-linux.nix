{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bmon
    lm_sensors
    psensor
    #nvtop #nonfree
  ];
}
