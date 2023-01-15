{ ... }:

{
  programs.helix = { enable = true; };

  home.file.".config/helix/config.toml".text = ''
    theme = "dracula"

    [editor]
    scrolloff = 9999999999
    cursorline = true
    bufferline = "multiple"

    [editor.cursor-shape]
    insert = "bar"
    select = "underline"

    [editor.whitespace.render]
    space = "none"
    tab = "all"
    newline = "all"

    [editor.whitespace.characters]
    space = "·"
    nbsp = "⍽"
    tab = "→"
    newline = "⏎"
    tabpad = "·" # Tabs will look like "→···" (depending on tab width)

    [editor.indent-guides]
    render = true
    character = "⸽"
    skip-levels = 1
  '';
}
