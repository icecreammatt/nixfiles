{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    qmk
    avrdude
  ];
}
