{pkgs, ...}: {
  home.file.".config/broot/conf.hjson".source = ./broot/conf.hjson;
  home.file.".config/broot/verbs.hjson".source = ./broot/verbs.hjson;
  home.file."nixfiles/.dotfiles_temp/.config/broot/conf.hjson".text = builtins.readFile ./broot/conf.hjson;
  home.file."nixfiles/.dotfiles_temp/.config/broot/verbs.hjson".text = builtins.readFile ./broot/verbs.hjson;
  home.packages = with pkgs; [
    broot # terminal explorer
  ];
}
