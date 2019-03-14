# Never know when you're gonna need to popd!
#
setopt AUTO_PUSHD
# Search all the things
bindkey '^R' history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

export BUNDLER_EDITOR=vim
export EDITOR=vim

export LC_ALL=en_US.UTF-8

# HOMEBREW WITH NO BEER
export HOMEBREW_INSTALL_BADGE=☕️

#GOOOOOO
export GOPATH=$HOME/go

fpath=(/usr/local/share/zsh/site-functions /usr/local/share/zsh-completions $fpath)
autoload -Uz compinit promptinit colors
compinit -i
promptinit
colors

setopt prompt_subst
setopt NO_BEEP

LS_COMMON="-hBG"

# setup the main ls alias if we've established common args
# test -n "$LS_COMMON" && alias ls="command ls $LS_COMMON"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source $HOME/.zsh/aliases
source $HOME/.zsh/functions

prompt pure

export PATH=$HOME/src/heroku-shell/bin:$GOPATH/bin:$HOME/bin:$PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash

if [ -z "$(pgrep -u "$USER" gpg-agent)" ]; then
  gpg-agent --daemon --enable-ssh-support
fi
export GPG_AGENT_INFO="$(gpgconf --list-dir agent-socket):0:1"
export SSH_AUTH_SOCK="$(gpgconf --list-dir agent-ssh-socket)"
export GPG_TTY=$(tty)
export KEY_ID=0DA4D16C648617DD
export DISABLE_SPRING=1

# heroku autocomplete setup
CLI_ENGINE_AC_ZSH_SETUP_PATH=/Users/yschutz/Library/Caches/heroku/completions/zsh_setup && test -f $CLI_ENGINE_AC_ZSH_SETUP_PATH && source $CLI_ENGINE_AC_ZSH_SETUP_PATH;

# added by travis gem
[ -f /Users/yschutz/.travis/travis.sh ] && source /Users/yschutz/.travis/travis.sh
