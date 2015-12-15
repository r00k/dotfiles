# Never know when you're gonna need to popd!
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
export JRUBY_OPTS="--1.9"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# HOMEBREW WITH NO BEER
export HOMEBREW_INSTALL_BADGE=☕️

cdpath=($HOME/src/go/src $HOME/src)
#GOOOOOO
export GOPATH=$HOME/src/go
fpath=(/usr/local/share/zsh/site-functions /usr/local/share/zsh-completions $fpath)

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# Theme
# get the name of the branch we are on

setopt prompt_subst
setopt NO_BEEP

LS_COMMON="-hBG"

# setup the main ls alias if we've established common args
test -n "$LS_COMMON" && alias ls="command ls $LS_COMMON"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby 2.1.2

#alias gh to git
eval "$(gh alias -s)"

source $HOME/.zshrc_private
source $HOME/.zsh/aliases
source $HOME/.zsh/functions

# prompt

function __git_prompt {
  local DIRTY="%{$fg[yellow]%}"
  local CLEAN="%{$fg[green]%}"
  local UNMERGED="%{$fg[red]%}"
  local RESET="%{$terminfo[sgr0]%}"
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]
  then
    echo -n "["
    if [[ `git ls-files -u >& /dev/null` == '' ]]
    then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]
      then
        echo -n $DIRTY
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]
        then
          echo -n $DIRTY
        else
          echo -n $CLEAN
        fi
      fi
    else
      echo -n $UNMERGED
    fi
    echo -n `git branch | grep '* ' | sed 's/..//'`
    echo -n $RESET
    echo -n "]"
  fi
}

# put fancy stuff on the right
RPS1='$(__git_prompt)%{$reset_color%} $EPS1'

# basic prompt on the left
PROMPT='%{$reset_color%}%2c% $ ' #%(?.%{$fg[green]%}.%{$fg[red]%})%B $%b '

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export PATH=$PATH:$GOPATH/bin:$HOME/bin
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
