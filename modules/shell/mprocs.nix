{
  home.file.".config/mprocs/mprocs.yaml".text = ''
    keymap_procs: # keymap when process list is focused
      <e>: {c: next-proc }
      <u>: {c: prev-proc }
    # keymap_term: # keymap when terminal is focused
      # <C-e>:
        # c: batch
        # cmds:
          # - { c: focus-procs }
          # - { c: next-proc }
      # reset: true
  '';
}
