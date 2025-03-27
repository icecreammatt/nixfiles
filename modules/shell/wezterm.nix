{darkmode, ...}: let
  theme =
    if darkmode
    then "Catppuccin Frappe"
    else "Catppuccin Latte";

  background_color =
    if darkmode
    then "#2E3440"
    else "#EFF1F5";

  foreground_color =
    if darkmode
    then "#D8DEE9"
    else "#7287FD";
in {
  home.file.".config/wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
  home.file.".config/wezterm/theme.lua".text = ''
    local theme_config = {
      background_color = "${background_color}",
      foreground_color = "${foreground_color}",
      theme = "${theme}"
    }
    return theme_config
  '';

  # Copy files into stow directory for use in non nix systems
  home.file."nixfiles/.dotfiles_temp/.config/wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
  home.file."nixfiles/.dotfiles_temp/.config/wezterm/theme.lua".text = ''
    local theme_config = {
      background_color = "${background_color}",
      foreground_color = "${foreground_color}",
      theme = "${theme}"
    }
    return theme_config
  '';
}
