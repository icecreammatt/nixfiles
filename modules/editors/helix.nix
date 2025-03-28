{darkmode, ...}: let
  theme =
    if darkmode
    then "catppuccin_frappe"
    else "catppuccin_latte";
  # theme = "nord"
  # icons = "nerdfonts"

  hxConfig = ''
    theme = "${theme}"

    [editor.inline-blame]
    enable = true

    [editor]
    scrolloff = 10
    cursorline = true
    bufferline = "multiple"
    mouse = false
    color-modes = true

    [editor.lsp]
    display-inlay-hints = true

    [editor.soft-wrap]
    enable = true

    # [editor.icons]
    # enable = true
    # bufferline = true
    # picker = true
    # statusline = true

    [editor.statusline]
    right = ["version-control", "diagnostics", "selections", "position", "file-encoding"]

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
    # "," = { s = "normal_mode" }
    # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
    esc = ["collapse_selection", "normal_mode"]

    [keys.normal.space.i]
    c = ":toggle inline-diagnostics.cursor-line hint disable"
    e = ":toggle end-of-line-diagnostics warning disable"
    o = ":toggle inline-diagnostics.other-lines error disable"

    [keys.normal.space]
    f = "file_picker"
    F = "file_picker_in_current_buffer_directory"

    g = ":pipe-to wezterm cli split-pane -- helix-live-grep"
    B = ":pipe-to wezterm cli split-pane -- helix-git-blame"

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
    C-k = ["extend_to_line_bounds", "delete_selection", "paste_after"]
    C-j = ["extend_to_line_bounds", "delete_selection", "move_line_up", "paste_before"]
    "*" = ["move_char_right", "move_prev_word_start", "move_next_word_start", "search_selection"]
    "C-/" = "toggle_comments"
    C-y = [
      ':sh rm -f /tmp/unique-file',
      ':insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file',
      ':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty',
      ':open %sh{cat /tmp/unique-file}',
      ':redraw',
    ]

    # -------------------------
    # QWERTY to Colemak remaps
    # [JY] [LU] [UI] [..]
    #  [..] [NJ] [EK] [IL]
    #   [KN] [..] [..] [..]
    # -------------------------
    "," = { s = ":sh /Users/matt/Library/Application\\ Support/Blender/3.5/scripts/send.py", d = ['select_mode', 'move_prev_word_start', 'move_next_word_end', 'search_selection', 'extend_search_next', 'exit_select_mode'], D = ['select_mode', 'move_prev_word_start', 'move_next_word_end', 'search_selection', 'extend_search_prev', 'exit_select_mode'],  Q = "wclose", q = ":buffer-close", w = ":w", W = ":write-quit", g = ":run-shell-command lazygit", r = ":theme ${theme}", R = ":theme nord", m = ":lsp-workspace-command", p = "file_picker_in_current_directory", c = ":set gutters.line-numbers.min-width 30", C = ":set gutters.line-numbers.min-width 0", "," = ["collapse_selection", "keep_primary_selection"]  }

    "C-p" = "file_picker_in_current_directory"
    "C-r" = "file_picker_in_current_directory"
    "C-l" = "page_up"

    "C-n" = "jump_view_left"
    "C-e" = "jump_view_down"
    "C-u" = "jump_view_up"
    "C-i" = "jump_view_right"

    X = ["extend_line_up", "extend_to_line_bounds"]

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

    # p = ":clipboard-paste-after"
    # P = ":clipboard-paste-before"
    # y = ":clipboard-yank-join"
    # Y = ":clipboard-yank"
    # R = ":clipboard-paste-replace"
    # d = [":clipboard-yank-join", "delete_selection"]

    # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
    esc = ["collapse_selection", "keep_primary_selection"]

    # Muscle memory
    "{" = ["goto_prev_paragraph", "collapse_selection"]
    "}" = ["goto_next_paragraph", "collapse_selection"]
    "N" = "goto_first_nonwhitespace"
    "$" = "goto_line_end"
    "0" = "goto_line_start"
    "I" = "goto_line_end"
    "^" = "goto_first_nonwhitespace"
    G = "goto_file_end"

    [keys.select]
    "N" = "goto_first_nonwhitespace"
    "I" = "goto_line_end"
    "$" = "goto_line_end"
    "0" = "goto_line_start"
    "^" = "goto_first_nonwhitespace"
    G = "goto_file_end"
    "{" = "goto_prev_paragraph"
    "}" = "goto_next_paragraph"

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
  theme_nord = ''
    inherits = "nord"
    "ui.background" = {}
  '';

  theme_catppuccin_latte = ''
    inherits = "catppuccin_latte"
    "ui.background" = {}
  '';

  languages = ''
    [[language]]
    name = "markdown"
    scope = "source.md"
    injection-regex = "md|markdown"
    file-types = ["md", "markdown" ]
    roots = [".zk"]
    language-servers = ["zk", "mdpls"]

    [language-server.zk]
    command = "zk"
    args = ["lsp"]

    [language-server.godot]
    command = "nc"
    args = [ "127.0.0.1", "6005" ]

    [[language]]
    name = "gdscript"
    language-servers = ["godot"]

    [language-server.mdpls]
    command = "mdpls"

    [[language]]
    name = "nix"
    scope = "source.nix"
    injection-regex = "nix"
    comment-token = "#"
    file-types = [ "nix" ]
    shebangs = []
    language-servers = ["nil"]
    formatter = { command = "alejandra" }
    auto-format = true

    [language-server.nil]
    command = "nil"

    [[language]]
    name = "yaml"
    file-types = ["yaml", "yml"]
    indent = { tab-width = 2, unit = "  " }

    [[language]]
    name = "css"
    file-types = ["css"]
    indent = { tab-width = 4, unit = "    " }

    [[language]]
    name = "java"
    scope = "source.java"
    injection-regex = "java"
    file-types = ["java", "groovy", "wse"]
    roots = ["pom.xml", "build.gradle"]
    indent = { tab-width = 2, unit = "  " }

    [language-server.jdt-language-server]
    command = "jdt-language-server"

    [[language]]
    name = "javascript"
    file-types = ["js"]

    [[language]]
    name = "ini"
    file-types = [
      "conf",

      # from https://github.com/helix-editor/helix/blob/master/languages.toml
      "ini", "service", "automount", "device", "mount", "path", "service", "slice", "socket", "swap", "target", "timer", "container", "volume", "kube", "network",
    ]

    [[language]]
    name = "bash"
    file-types = [
      "nginx.conf",

      # from https://github.com/helix-editor/helix/blob/master/languages.toml
      "sh", "bash", "zsh", ".bash_login", ".bash_logout", ".bash_profile", ".bashrc", ".profile", ".zshenv", "zshenv", ".zlogin", "zlogin", ".zlogout", "zlogout", ".zprofile", "zprofile", ".zshrc", "zshrc", ".zimrc", "APKBUILD", "PKGBUILD", "eclass", "ebuild", "bazelrc", ".bash_aliases", "Renviron", ".Renviron", "template", "inc",
    ]

    [[language]]
    name = "json"
    file-types = ["json", "lock", ".releaserc", "pp"]

    [[grammar]]
    name = "java"
    source = { git = "https://github.com/tree-sitter/tree-sitter-java", rev = "09d650def6cdf7f479f4b78f595e9ef5b58ce31e" }
  '';
in {
  # programs.helix = {enable = true;};

  home.file.".config/helix/config.toml".text = hxConfig;
  home.file.".config/helix/themes/nord-clear.toml".text = theme_nord;
  home.file.".config/helix/themes/catppuccin_latte-clear.toml".text = theme_catppuccin_latte;
  home.file.".config/helix/languages.toml".text = languages;

  home.file."nixfiles/.dotfiles_temp/.config/helix/config.toml".text = hxConfig;
  home.file."nixfiles/.dotfiles_temp/.config/helix/themes/nord-clear.toml".text = theme_nord;
  home.file."nixfiles/.dotfiles_temp/.config/helix/themes/catppuccin_latte-clear.toml".text = theme_catppuccin_latte;
  home.file."nixfiles/.dotfiles_temp/.config/helix/languages.toml".text = languages;
}
