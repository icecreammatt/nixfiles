{pkgs, ...}: {
  home.packages = with pkgs; [
    qmk
    avrdude
  ];
}
