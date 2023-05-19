# 

# Load seperated config files
for conf in "./.zsh.d/"*.zsh; do
  source "${conf}"
done
unset conf

# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.
# Periodic auto-update on Zsh startup: 'ask' or 'no'.
#
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'
# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'
function rem() {
    TIME_SPEC_REGEX="(in\s[0-9]+\s(minutes|minute|hours|hour)|at\s[0-9]{1,2}(:[0-9]{2})?\s?(am|pm|AM|PM)?|tomorrow\s( at)?\s[0-9]{1,2}(:[0-9]{2})?\s?(am|pm|AM|PM)?|[0-9]+(m|h|d))"
    TIME_SPEC=$(echo "$*" | grep -oE "$TIME_SPEC_REGEX")
    REMINDER_MESSAGE=$(echo "$*" | sed "s/$TIME_SPEC//")

    case "$TIME_SPEC" in
        in\ *min*|in\ *minute*|*m)
            TIME_STRING="now + ${TIME_SPEC#*in }"
            TIME_STRING="${TIME_STRING%m*} minutes"
            ;;
        in\ *hour*|*h)
            TIME_STRING="now + ${TIME_SPEC#*in }"
            TIME_STRING="${TIME_STRING%h*} hours"
            ;;
        *d)
            TIME_STRING="now + ${TIME_SPEC%d*} days"
            ;;
        at\ *)
            TIME=$(date -d "${TIME_SPEC#*at }" "+%H:%M")
            TIME_STRING="today $TIME"
            ;;
        tomorrow\ *)
            TIME=$(date -d "${TIME_SPEC#*tomorrow }" "+%H:%M")
            TIME_STRING="tomorrow $TIME"
            ;;
        *)
            echo "Invalid time specification."
            return 1
            ;;
    esac

    echo "$HOME/scripts/reminder.sh '$REMINDER_MESSAGE'" | at $TIME_STRING
}
zstyle ':z4h:' start-tmux no


if [[ -z "$TMUX" ]]; then
  echo 'has been called'
  source $HOME/scripts/count_programs.zsh
  num_programs=$?

  if [ $num_programs -lt 2 ]; then
    tmuxinator_project="bonsai"
  else
    tmuxinator_project="bonsai_small"
  fi

  echo $tmuxinator_project
  tmuxinator start $tmuxinator_project

else
  source $HOME/.dotfiles/scripts/count_programs.zsh
  num_programs=$?


  if [ $num_programs -lt 2 ]; then
    tmuxinator_project="bonsai"
  else
    tmuxinator_project="bonsai_small"
  fi
  
  if tmux has-session -t $tmuxinator_project 2>/dev/null; then
    echo "Attaching to session $tmuxinator_project"
    tmux attach -t $tmuxinator_project
  else
    echo "Creating and starting session $tmuxinator_project"
    tmuxinator start $tmuxinator_project
  fi
fi

# zstyle ':z4h:'  tmuxifier load-session example.window.sh

# send_tmux_keys_once() {
#   if [[ $TMUX ]]; then
#     send_tmux_keys
#     # Remove the hook after the function is called
#     add-zsh-hook -d -Uz zshaddhistory send_tmux_keys_once
#   fi
# }
#
# autoload -Uz add-zsh-hook
# add-zsh-hook -Uz zshaddhistory send_tmux_keys_once


# 
# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return
# tmuxifier load-session ~/example.window.sh
# Extend PATH.
path=(~/bin $path)

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin
# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

alias cd="z"
alias b="cd .."




# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf
#
#

export PATH=$PATH:~/.dotfiles/scripts
# function create-react-tailwind() {
#   if [ -z "$1" ]
#   then
#     echo "Please provide a project name."
#     return 1
#   fi
#
#   project_name=$1
#
#   echo "Creating a new React project..."
#   npx create-react-app $project_name
#
#   cd $project_name
#
#   echo "Installing Tailwind CSS and its dependencies..."
#   npm install tailwindcss@latest postcss@latest autoprefixer@latest
#
#   echo "Creating Tailwind CSS configuration file..."
#   npx tailwindcss init
#
#   echo "Creating PostCSS configuration file..."
#   echo "module.exports = {
#     plugins: [
#       require('tailwindcss'),
#       require('autoprefixer'),
#     ],
#   };" > postcss.config.js
#
#   echo "Setting up src/index.css..."
#   echo "@tailwind base;
#   @tailwind components;
#   @tailwind utilities;" > src/index.css
#
#   echo "Rebuilding the project with Tailwind CSS..."
#   npm run build
#
#   echo "Your new React project with Tailwind CSS is ready!"
# }
#
#
