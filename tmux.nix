{
    programs.tmux = {
        enable = true;
        extraConfig = ''
            set-environment -g PATH  "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.cargo/bin"

            # Change ctrl-b default tmux activation to ctrl-o
            unbind-key C-b
            set -g prefix 'C-o'
            bind-key 'C-o' send-prefix

            # force a reload of the config file
            # unbind r
            # bind r source-file ~/.tmux.conf

            # force a reload of the theme config file
            # unbind t
            # bind t source-file ~/.tmux.theme
            # bind t source-file ~/dotfiles/configs/tomorrow.tmux.theme


            # set aggressive resizing for mixed display sizes and shared sessions
            setw -gq aggressive-resize

            # start window numbering at 1 for easier switching
            set -g base-index 1

            # unicode
            # setw -gq utf8 on
            # set -gq status-utf8 on

            # status bar config
            # set -g status-left "#h:[#S]"
            # set -g status-left "[#S]"
            set -g status-left ""
            set -g status-left-length 50
            set -g status-right-length 50
            set -g status-right "#() | %H:%M %d-%h-%Y "
            setw -g window-status-current-format "|#I:#W|"
            set-window-option -g automatic-rename on
            set-option -g allow-rename on

            set -g history-limit 10000

            # listen to alerts from all windows
            set -g bell-action any

            # rebind pane tiling
            bind v split-window -h -c "#{pane_current_path}"
            bind s split-window -c "#{pane_current_path}"
            bind c new-window -c "#{pane_current_path}"

            # reload config
            # bind r source-file ~/.tmux.conf \; display-message "tmux configuration file"

            # tmux theme
            # source-file ~/dotfiles/configs/tomorrow.tmux.theme


            is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'" 
            bind -n C-k run-shell "if $is_vim ; then tmux send-keys C-k ; else tmux select-pane -U; fi"
            bind -n C-j run-shell "if $is_vim ; then tmux send-keys C-j; else tmux select-pane -D; fi"
            bind -n C-h run-shell "if $is_vim ; then tmux send-keys C-h; else tmux select-pane -L; fi"
            bind -n C-l run-shell "if $is_vim ; then tmux send-keys C-l; else tmux select-pane -R; fi"

            # Fix clear screen
            bind C-l send-keys 'C-l'

            # Fix yank
            bind C-k send-keys 'C-k'

            # Mouse Mode Settings
            set -gq mouse-utf8 on
            set -gq mouse on
            # bind -n WheelUpPane select-pane -t= '\'; copy-mode -e \; send-keys -M
            # bind -n WheelDownPane select-pane -t= '\'; send-keys -M

            # Copy-paste integration
            # set-option -g default-command "reattach-to-user-namespace -l fish"

            # Use vim keybindings in copy mode
            setw -g mode-keys vi

            # Setup 'v' to begin selection as in Vim
            # bind-key -T copy-mode-vi v send-keys -X begin-selection
            # bind-key -T copy-mode-vi y send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"

            # Update default binding of `Enter` to also use copy-pipe
            #unbind -T copy-mode-vi Enter
            #bind-key -T copy-mode-vi Enter send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"

            # https://github.com/tmux/tmux/issues/754

            # List of plugins
            set -g @plugin 'tmux-plugins/tpm'
            set -g @plugin 'tmux-plugins/tmux-sensible'

            # Other examples:
            # set -g @plugin 'github_username/plugin_name'
            # set -g @plugin 'git@github.com/user/plugin'
            # set -g @plugin 'git@bitbucket.com/user/plugin'
            set -g @plugin 'tmux-plugins/tmux-resurrect'
            set -g @plugin 'tmux-plugins/tmux-continuum'
            TMUX_FZF_LAUNCH_KEY="C-f"

            # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
            # run '~/.tmux/plugins/tpm/tpm'

            set-option -g default-shell $HOME/.nix-profile/bin/fish
            set -g default-command $HOME/.nix-profile/bin/fish

            '';
    };
}
