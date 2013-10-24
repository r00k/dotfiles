# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="yann_ck"

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD
# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Show contents of directory after cd-ing into it
# chpwd() {
#   ls -lrthG
# }

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
#DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

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
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

#GOOOOOO
export GOPATH=$HOME/code/go

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew osx git rails3 ruby rbenv bundler)
#DISABLE AUTOCORRECT
unsetopt correct

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc_private

# Source my custom files after oh-my-zsh so I can override things.
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

export PATH=$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/bin:/usr/local/share/npm/bin:/usr/local/share/python:/usr/bin:/sbin:/bin:/usr/sbin:/usr/X11/bin:$PATH
# Customize to your needs...
# rbenv
eval "$(rbenv init - --no-rehash)"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
export PATH=/usr/local/heroku/bin:$PATH


# Wrap git automatically by adding the following to ~/.zshrc:

eval "$(hub alias -s)"
