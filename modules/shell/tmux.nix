{ pkgs, ... }:
{
    programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          { 
            plugin = dracula; 
            extraConfig = ''
              set -g @dracula-show-powerline true
              set -g @dracula-plugins "cpu-usage ram-usage battery time"
              set -g @dracula-refresh-rate 10
              set -g @dracula-show-location false
            '';
          }
          { plugin = sensible; }
          { 
            plugin = extrakto; 
            extraConfig = ''
              set -g @extrakto_filter_order "line word all"
            '';
          }
          { 
            plugin = tmux-fzf; 
            extraConfig = ''
              set -g @plugin 'sainnhe/tmux-fzf'
              TMUX_FZF_LAUNCH_KEY="C-f"
            '';
          }
        ];
        extraConfig = ''
            #set-environment -g PATH  "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.cargo/bin"
            #set-option -g default-shell $HOME/.nix-profile/bin/fish
            set -g default-command fish

            set -g @scroll-speed-num-lines-per-scroll 0.25
            set -g pane-border-status top
            set -g pane-border-format "[#[fg=white]#{?pane_active,#[bold],} #T #[fg=default,nobold]]"
            # Change ctrl-b default tmux activation to ctrl-o
            unbind-key C-b
            set -g prefix 'C-o'
            bind-key 'C-o' send-prefix

            bind-key -n 'F12' resize-pane -Z
            bind-key -n 'F3' split-window -v -p 22 'fish'

            set-option -g status-position top

            bind r source ~/.config/tmux/tmux.conf

            # Undercurl
            # set -g default-terminal "{TERM}"
            #set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
            #set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0


            # set aggressive resizing for mixed display sizes and shared sessions
            setw -gq aggressive-resize

            # start window numbering at 1 for easier switching
            set -g base-index 1

            # set -g status-left ""
            # set -g status-left-length 50
            # set -g status-right-length 50
            # set -g status-right "#() | %H:%M %d-%h-%Y "
            # setw -g window-status-current-format "|#I:#W|"
            # set-window-option -g automatic-rename on
            # set-option -g allow-rename on

            set -g history-limit 10000

            # listen to alerts from all windows
            set -g bell-action any

            # rebind pane tiling
            bind v split-window -h -c "#{pane_current_path}"
            bind s split-window -c "#{pane_current_path}"
            bind c new-window -c "#{pane_current_path}"

            is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'" 
            bind -n C-k run-shell "if $is_vim ; then tmux send-keys C-k ; else tmux select-pane -U; fi"
            bind -n C-j run-shell "if $is_vim ; then tmux send-keys C-j; else tmux select-pane -D; fi"
            bind -n C-h run-shell "if $is_vim ; then tmux send-keys C-h; else tmux select-pane -L; fi"
            bind -n C-l run-shell "if $is_vim ; then tmux send-keys C-l; else tmux select-pane -R; fi"

            bind -n M-k run-shell "if $is_vim ; then tmux send-keys M-k; else tmux resize-pane -U; fi"
            bind -n M-j run-shell "if $is_vim ; then tmux send-keys M-j; else tmux resize-pane -D; fi"
            bind -n M-h run-shell "if $is_vim ; then tmux send-keys M-h; else tmux resize-pane -L; fi"
            bind -n M-l run-shell "if $is_vim ; then tmux send-keys M-l; else tmux resize-pane -R; fi"

            # switch windows alt+number
            bind-key -n M-1 select-window -t 1
            bind-key -n M-2 select-window -t 2
            bind-key -n M-3 select-window -t 3
            bind-key -n M-4 select-window -t 4
            bind-key -n M-5 select-window -t 5
            bind-key -n M-6 select-window -t 6
            bind-key -n M-7 select-window -t 7
            bind-key -n M-8 select-window -t 8
            bind-key -n M-9 select-window -t 9

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

            # Other examples:
            # set -g @plugin 'github_username/plugin_name'
            # set -g @plugin 'git@github.com/user/plugin'
            # set -g @plugin 'git@bitbucket.com/user/plugin'

            set-option -g status-interval 1
            set-option -g automatic-rename on
            set-option -g automatic-rename-format "#{?#{==:#{pane_current_command},fish},#{b:pane_current_path},#{pane_current_command}}"
            '';
    };
}
