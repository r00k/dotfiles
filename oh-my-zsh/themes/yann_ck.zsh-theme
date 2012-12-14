
PROMPT='%{$fg[red]%}‹$(rbenv version-name)› %{$fg[yellow]%}%c  %{$reset_color%}'
RPROMPT='$(git_prompt_info)'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} ]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}+"
