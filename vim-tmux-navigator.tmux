#!/usr/bin/env bash

version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

tmux bind-key -n C-w switch-client -T window-keys
tmux bind-key -T window-keys  h if-shell "$is_vim" "send-keys C-w h" "select-pane -L"
tmux bind-key -T window-keys  j if-shell "$is_vim" "send-keys C-w j" "select-pane -D"
tmux bind-key -T window-keys  k if-shell "$is_vim" "send-keys C-w k" "select-pane -U"
tmux bind-key -T window-keys  l if-shell "$is_vim" "send-keys C-w l" "select-pane -R"
tmux bind-key -T window-keys  C-h if-shell "$is_vim" "send-keys C-w C-h" "select-pane -L"
tmux bind-key -T window-keys  C-j if-shell "$is_vim" "send-keys C-w C-j" "select-pane -D"
tmux bind-key -T window-keys  C-k if-shell "$is_vim" "send-keys C-w C-k" "select-pane -U"
tmux bind-key -T window-keys  C-l if-shell "$is_vim" "send-keys C-w C-l" "select-pane -R"
tmux bind-key -T window-keys  s if-shell "$is_vim" "send-keys C-w s" 
tmux bind-key -T window-keys  C-s if-shell "$is_vim" "send-keys C-w s" 
tmux bind-key -T window-keys  v if-shell "$is_vim" "send-keys C-w v" 
tmux bind-key -T window-keys  C-v if-shell "$is_vim" "send-keys C-w v" 
tmux bind-key -T window-keys  n if-shell "$is_vim" "send-keys C-w n" 
tmux bind-key -T window-keys  C-n if-shell "$is_vim" "send-keys C-w n" 
tmux bind-key -T window-keys  q if-shell "$is_vim" "send-keys C-w q" 
tmux bind-key -T window-keys  C-q if-shell "$is_vim" "send-keys C-w q" 
tmux bind-key -T window-keys  o if-shell "$is_vim" "send-keys C-w o" 
tmux bind-key -T window-keys  C-o if-shell "$is_vim" "send-keys C-w o" 
tmux bind-key -T window-keys  \\ if-shell "$is_vim" "send-keys C-w \\" 
tmux bind-key -T window-keys  C-\\ if-shell "$is_vim" "send-keys C-w \\" 

tmux_version="$(tmux -V | sed -En "$version_pat")"
tmux setenv -g tmux_version "$tmux_version"

#echo "{'version' : '${tmux_version}', 'sed_pat' : '${version_pat}' }" > ~/.tmux_version.json

tmux if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
  "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
tmux if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
  "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

tmux bind-key -T copy-mode-vi M-h select-pane -L
tmux bind-key -T copy-mode-vi M-j select-pane -D
tmux bind-key -T copy-mode-vi M-k select-pane -U
tmux bind-key -T copy-mode-vi M-l select-pane -R
tmux bind-key -T copy-mode-vi M-\\ select-pane -l
