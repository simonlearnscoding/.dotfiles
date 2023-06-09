
# Define aliases.
alias l="exa --icons -a --group-directories-first --icons"
alias ls="exa --icons -a --group-directories-first --icons"
alias tree='tree -a -I .git'
alias lpg='lp -o Ink=MONO'
alias cl="tmux kill-pane"
alias lst="exa --group-directories-first --icons -a -T -L=2"
alias lsl="exa --group-directories-first -l --icons --no-permissions --no-user   -m -h  -a "
alias nv= "neovide --multigrid"
alias lg="ls | grep"
alias see="batcat"
alias rn="task add planned:tod priority:H"
alias tod="task add planned:tod"


# Create a new command 'c' which is equivalent to 'z' from zoxide
# alias c="z"

# Override c command
c() {
    z "$@" && echo "$PWD" > ~/.current_dir
}

# Create a new command 'ci' which is equivalent to 'zi' from zoxide
# alias ci="zi"

# Override ci command
ci() {
    zi "$@" && echo "$PWD" > ~/.current_dir
}


b() {
    
    z .. && echo "$PWD" > ~/.current_dir
}


alias gg="lazygit"

alias open="xdg-open"
alias aio="C-b Tab"
alias tt="taskwarrior-tui"
alias ai="aichat"
alias cdadd="zoxide add"
alias tv="nvim /home/simone/projects/vault/Tasks.md"
alias tvi="neovide --nofork /home/simone/projects/vault/Tasks.md"
alias t="task '(depends: )'"
alias tdel="task delete"
alias tc="task context "
alias tp="task projects"
alias ta='task add'
alias td='task done'
alias tat='task add planned:tod'
alias taw='task add planned:tw' 
alias tm='task modify'
alias r='trash-put'
