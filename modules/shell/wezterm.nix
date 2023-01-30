{ ... }:

{
  programs.wezterm.enable = true;
  home.file.".config/wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
}
