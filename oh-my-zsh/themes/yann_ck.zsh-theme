
PROMPT='%{$fg[red]%}‹$(rbenv version-name)› $(git_prompt_info)%{$reset_color%} %{$fg[yellow]%}${PWD/#$HOME/~}  %{$reset_color%}'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}[%F{154}%f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%B±%b%F{154}%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}±%F{154}"
