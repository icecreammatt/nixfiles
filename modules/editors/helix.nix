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
    character = "|"
    skip-levels = 1

    [keys.insert]
    "," = { s = "normal_mode" }

    [keys.normal]
    # -------------------------
    # QWERTY to Colemak remaps
    # [JY] [LU] [UI] [..]
    #  [..] [NJ] [EK] [IL]
    #   [KN] [..] [..] [..]
    # -------------------------

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
}
