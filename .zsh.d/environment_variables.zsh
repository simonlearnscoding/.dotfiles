
# Export environment variables.
export FZF_DEFAULT_COMMAND='/usr/bin/fdfind --type f --color=never --hidden'
export FZF_DEFAULT_OPTS=' --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export PATH="/home/simone/.tmuxifier/bin:$PATH"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS=" --preview '/usr/bin/batcat --line-range :50 {}'"
export FZF_CTRL_T_OPTS="--preview '/usr/bin/batcat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='/usr/bin/fdfind --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 80%'
export GOOGLE_APPLICATION_CREDENTIALS="/home/simone/tts-api.json"
export EDITOR="/usr/bin/nvim"
export GPG_TTY=$TTY
eval "$(zoxide init bash)"
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export PATH="/home/simone/.tmuxifier/bin:$PATH"
export PATH="$PATH:$HOME/AppImages"
eval "$(tmuxifier init -)"
