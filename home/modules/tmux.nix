{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    terminal = "alacritty";
    historyLimit = 10000;
    escapeTime = 0;
    aggressiveResize = true;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-save 'S'
          set -g @resurrect-restore 'R'
        '';
      }
      sensible
      #vim-tmux-navigator
    ];

    extraConfig = ''
      setw -g pane-base-index 1
      set -g allow-rename on
      set -g renumber-windows on
      set -ag terminal-overrides ",alacritty:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set -g focus-events on
      set -g detach-on-destroy off
      setw -g monitor-activity on
      set -g bell-action any
      set -g visual-bell off
      set -g visual-activity off

      # Status line
      set-option -g status-left-length 100
      set-option -g status-right-length 500
      set-option -g status-right "#(tmux-spotify) < %I:%M%p #(date '+%%d/%%m/%%Y')"
      set-option -g status-left "yenidnya > "
      set-option -g status-style "fg=#7C7D83 bg=default"
      set-option -g window-status-format "#{window_index}:#{window_name}#{window_flags} "
      set-option -g window-status-current-format "#{window_index}:#{window_name}#{window_flags} "
      set-option -g window-status-current-style "fg=#dcc7a0"
      set-option -g window-status-activity-style none
      set-option -g status-interval 5

      # Key bindings
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf\; display-message 'tmux.conf reloaded'
      bind C-p previous-window
      bind C-n next-window

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -r C-h swap-window -d -t -1
      bind -r C-l swap-window -d -t +1

      is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\\/)?g?(view|n?vim?)(diff)?$"'
      bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
      bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
      bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
      bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

      bind -r n next-window
      bind -r p previous-window

      bind -r N run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) + 1)"
      bind -r P run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) - 1)"

      bind -r s command-prompt -p "swap this with" "swap-window -s '%%'"
      bind Space last-window
      bind b switch-client -l
      bind q kill-session
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind y run -b "tmux show-buffer | xclip -selection clipboard"\; display-message "copied tmux buffer to system clipboard"

      # tmux-resurrect config
    '';
  };
}
