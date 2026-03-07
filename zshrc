# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Enable completion
autoload -U compinit
compinit

# Disable flow control commands (keeps C-s from freezing everything)
if [[ -t 0 ]]; then
  stty start undef
  stty stop undef
fi

# Sourcing of other files
if [[ -f $HOME/.secrets ]]; then
  source $HOME/.secrets
fi
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
source $HOME/.dotfiles/zsh/prompt
source $HOME/.dotfiles/zsh/z

# Add custom bins without duplicating existing entries
typeset -U path PATH
path=(
  $HOME/.dotfiles/bin
  $HOME/.local/bin
  $HOME/bin
  $path
)
export PATH

# Update Homebrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=600000

# Enable mise (manages Ruby, Node, and other runtimes)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

alias python=python3
