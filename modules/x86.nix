{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bmon
    #qmk
    #avrdude
  ];
}
