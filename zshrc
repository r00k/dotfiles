# Path to your oh-my-zsh configuration.

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD
# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

export BUNDLER_EDITOR=vim
export EDITOR=vim
export JRUBY_OPTS="--1.9"
# -Xcompile.mode=FORCE --server --fast -J-Xmx1024M"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Ruby 1.9.3-px perf
#export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

#GOOOOOO
export GOPATH=$HOME/src/languages/go

autoload -U compinit promptinit colors
compinit
promptinit
colors

# Theme
PROMPT="$%2~ : "

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source $HOME/.zshrc_private

# Source my custom files after oh-my-zsh so I can override things.
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# rbenv
#eval "$(rbenv init - --no-rehash)"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# Wrap git automatically by adding the following to ~/.zshrc:

#eval "$(hub alias -s)"
export PATH=$PATH:$GOPATH/bin:$HOME/bin
