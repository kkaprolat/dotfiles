# ZSH Theme - classyTouch
# Author: Yaris Alex Gutierrez <yarisgutierrez@gmail.com>
# Prompt is the Oh-my-zsh version of user Graawr's 'Classy Touch' themes on http://dotshare.it

local current_dir='%{$fg[magenta]%}[%{$reset_color%}%~% %{$fg[magenta]%}]%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local current_time='%{$fg[green]%}[%{$reset_color%}%T%{$fg[green]%}]%{$reset_color%}'
local failed='%{$fg[red]%}[!]%{$reset_color%}'
local user='%{$fg[blue]%}[%{$reset_color%}%n%{$fg[blue]%}]%{$reset_color%}'


PROMPT="%(?,%{$fg[magenta]%}┌─╼${user}─${current_dir}─${current_time} ${git_branch}
%{$fg[magenta]%}└────╼%{$reset_color%} ,%{$fg[magenta]%}┌─╼${user}─${current_dir}─${current_time}─${failed} ${git_branch}
%{$fg[magenta]%}└────╼ %{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
