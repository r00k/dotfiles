# Path to your oh-my-zsh configuration.

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD
# Search all the things
bindkey '^R' history-incremental-search-backward

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

#GOOOOOO
export GOPATH=$HOME/src/languages/go

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# Theme
# get the name of the branch we are on

setopt prompt_subst

LS_COMMON="-hBG"

# setup the main ls alias if we've established common args
test -n "$LS_COMMON" && alias ls="command ls $LS_COMMON"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source $HOME/.zshrc_private
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# prompt
 
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}[%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
 
# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}
 
# show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}
 
# if in a git repo, show dirty indicator + git branch
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${git_where#(refs/heads/|tags/)}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
 
# show current rbenv version if different from rbenv global
rbenv_version_status() {
  local ver=$(rbenv version-name)
  [ "$(rbenv global)" != "$ver" ] && echo "[$ver]"
}
 
# put fancy stuff on the right
if which rbenv &> /dev/null; then
  RPS1='$(git_custom_status)%{$fg[red]%}$(rbenv_version_status)%{$reset_color%} $EPS1'
else
  RPS1='$(git_custom_status)%{$reset_color%} $EPS1'
fi
 
# basic prompt on the left
PROMPT='%{$reset_color%}%2c% $ ' #%(?.%{$fg[green]%}.%{$fg[red]%})%B $%b '

# rbenv
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# Wrap git automatically by adding the following to ~/.zshrc:

export PATH=$PATH:$GOPATH/bin:$HOME/bin
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
