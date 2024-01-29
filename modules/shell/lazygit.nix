{pkgs, ...}: {
  home.file.".config/lazygit/config.yml".source = ./lazygit/config.yaml;
  home.file."./Library/Application Support/lazygit/config.yml".source = ./lazygit/config.yaml;
}
