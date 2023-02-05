{ ... }:

{
  programs.helix = { enable = true; };

  home.file.".config/helix/config.toml".text = ''
    theme = "dracula"
    icons = "nerdfonts"

    [editor]
    scrolloff = 9999999999
    cursorline = true
    bufferline = "multiple"

    [editor.icons]
    # enable = true
    bufferline = true
    picker = true
    statusline = true

    [editor.cursor-shape]
    insert = "bar"

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
    character = "|"
    skip-levels = 1

    [keys.insert]
    "," = { s = "normal_mode" }

    [keys.normal.space]
    F = "file_picker"
    f = "file_picker_in_current_directory"

    [keys.normal]
    # -------------------------
    # QWERTY to Colemak remaps
    # [JY] [LU] [UI] [..]
    #  [..] [NJ] [EK] [IL]
    #   [KN] [..] [..] [..]
    # -------------------------

    "C-p" = "file_picker_in_current_directory"

    # N <=> K (swap, QWERTY position)
    e = "move_line_down"
    E = "keep_selections"
    k = "search_next"
    K = "search_prev"

    # E <=> J (swap actions)
    j = "move_next_word_end"
    J = "move_next_long_word_end"

    u = "move_line_up"
    U = "join_selections"

    # ILU loop
    # I => L
    i = "move_char_right"
    I = "insert_at_line_end"

    n = "move_char_left"
    N = "workspace_symbol_picker"

    s = "insert_mode"
    S = "insert_at_line_start"
    h = "select_regex"
    H = "split_selection"
    "A-h" = "split_selection_on_newline"

    # U => I (QWERTY position)
    # L => U (QWERTY position)
    l = "undo"
    L = "redo"

    p = ":clipboard-paste-after"
    P = ":clipboard-paste-before"
    y = ":clipboard-yank-join"
    Y = ":clipboard-yank"
    R = ":clipboard-paste-replace"
    d = [":clipboard-yank-join", "delete_selection"]

    [keys.select]
    p = ":clipboard-paste-after"
    P = ":clipboard-paste-before"
    y = ":clipboard-yank-join"
    Y = ":clipboard-yank"
    R = ":clipboard-paste-replace"
    d = [":clipboard-yank-join", "delete_selection"]

  '';

  home.file.".config/helix/languages.toml".text = ''
    [[language]]
    name = "markdown"
    language-server = { command = "mdpls" }
    config = { markdown.preview.auto = true, markdown.preview.browser = "firefox" }
   '';
}
