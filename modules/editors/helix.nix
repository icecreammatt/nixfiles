{ ... }:

{
  programs.helix = { enable = true; };

  home.file.".config/helix/config.toml".text = ''
    theme = "dracula"
    # icons = "nerdfonts"

    [editor]
    scrolloff = 9999999999
    cursorline = true
    bufferline = "multiple"
    mouse = false

    # [editor.icons]
    # enable = true
    # bufferline = true
    # picker = true
    # statusline = true

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

    [keys.normal.C-w]
    n = "jump_view_left"
    e = "jump_view_down"
    u = "jump_view_up"
    i = "jump_view_right"

    [keys.insert]
    "," = { s = "normal_mode" }
    # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
    esc = ["collapse_selection", "normal_mode"]

    [keys.normal.space]
    F = "file_picker"
    f = "file_picker_in_current_directory"

    [keys.normal."("]
    d = "goto_prev_diag"
    D = "goto_first_diag"
    g = "goto_prev_change"
    G = "goto_last_change"
    f = "goto_prev_function"
    t = "goto_prev_class"
    a = "goto_prev_parameter"
    c = "goto_prev_comment"
    T = "goto_prev_test"
    p = "goto_prev_paragraph"
    space = "add_newline_above"

    [keys.normal.")"]
    d = "goto_next_diag"
    D = "goto_last_diag"
    g = "goto_next_change"
    G = "goto_first_change"
    f = "goto_next_function"
    t = "goto_next_class"
    a = "goto_next_parameter"
    c = "goto_next_comment"
    T = "goto_next_test"
    p = "goto_next_paragraph"
    space = "add_newline_below"

    [keys.normal]
    # -------------------------
    # QWERTY to Colemak remaps
    # [JY] [LU] [UI] [..]
    #  [..] [NJ] [EK] [IL]
    #   [KN] [..] [..] [..]
    # -------------------------
    "," = { q = "wclose" }

    "C-p" = "file_picker_in_current_directory"
    "C-l" = "page_up"

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
    # I = "insert_at_line_end"

    n = "move_char_left"
    # N = "workspace_symbol_picker"

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

    # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
    esc = ["collapse_selection", "keep_primary_selection"]

    # Muscle memory
    "{" = ["goto_prev_paragraph", "collapse_selection"]
    "}" = ["goto_next_paragraph", "collapse_selection"]
    "N" = "goto_first_nonwhitespace"
    "$" = "goto_line_end"
    "I" = "goto_line_end"
    "^" = "goto_first_nonwhitespace"
    G = "goto_file_end"

    [keys.select]
    p = ":clipboard-paste-after"
    P = ":clipboard-paste-before"
    y = ":clipboard-yank-join"
    Y = ":clipboard-yank"
    R = ":clipboard-paste-replace"
    d = [":clipboard-yank-join", "delete_selection"]

    # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
    esc = ["collapse_selection", "keep_primary_selection", "normal_mode"]

    # Make selecting lines in visual mode behave sensibly
    u = ["extend_line_up", "extend_to_line_bounds"]
    e = ["extend_line_down", "extend_to_line_bounds"]

    # e = "extend_line_down"
    # u = "extend_line_up"
    i = "extend_char_right"
    n = "extend_char_left"

    # F = "extend_next_long_word_end"
    # f = "extend_next_word_end"
    # G = "extend_till_prev_char"
    # g = "extend_till_char"
    # T = "extend_prev_char"
    # t = "extend_next_char"

    # selection manipulation
    # r = "select_regex"
    # R = "split_selection"
    # o = "collapse_selection"
    # N = "join_selections"
    # E = "keep_selections"

  '';

  home.file.".config/helix/languages.toml".text = ''
    [[language]]
    name = "markdown"
    file-types = ["md", "markdown" ]
    language-server = { command = "mdpls" }

    [[language]]
    name = "java"
    scope = "source.java"
    injection-regex = "java"
    file-types = ["java", "groovy"]
    roots = ["pom.xml", "build.gradle"]
    language-server = { command = "jdtls" }
    indent = { tab-width = 4, unit = "    " }

    [[grammar]]
    name = "java"
    source = { git = "https://github.com/tree-sitter/tree-sitter-java", rev = "09d650def6cdf7f479f4b78f595e9ef5b58ce31e" }
   '';
}
