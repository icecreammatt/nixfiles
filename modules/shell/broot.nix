{pkgs, ...}: {
  home.file.".config/broot/conf.hjson".source = ./broot/conf.hjson;
  home.file.".config/broot/verbs.hjson".source = ./broot/verbs.hjson;
  home.packages = with pkgs; [
    broot # terminal explorer
  ];
}
