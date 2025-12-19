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
stty start undef
stty stop undef

# Sourcing of other files
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
source $HOME/.dotfiles/zsh/prompt
source $HOME/.dotfiles/zsh/z

# Add current directory bin
export PATH=$PATH:bin

# Add my own dotfiles bin
export PATH=$PATH:$HOME/.dotfiles/bin

# Homebrew bin is added via /opt/homebrew/bin in default PATH on Apple Silicon

# Add stack's bin
export PATH=$PATH:~/.local/bin

# Update hombrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=600000

# Enable mise (manages Ruby, Node, and other runtimes)
eval "$(mise activate zsh)"
