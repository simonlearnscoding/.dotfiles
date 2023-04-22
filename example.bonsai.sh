#!/bin/zsh
# new_window "example-window"
# # xdotool key --clearmodifiers "cmatrix -n -u -C cyan"
# Start a new tmux session and create a new window
# tmux new-window  "Example Window"
# Send the specified keys
TMUX_PREFIX="Control+a"
# tmux run_cmd "cmatrix"
# tmux run_cmd "clear"
# select_pane 2
# run_cmd "ls"
# Attach to the new session
tmux split-window -v -p 20
