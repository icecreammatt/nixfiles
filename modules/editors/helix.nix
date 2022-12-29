{ ... }:

{
  programs.helix = { enable = true; };

  home.file.".config/helix/config.toml".text = ''
    theme = "dracula"
  '';
}
