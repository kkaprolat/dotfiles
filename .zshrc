HISTFILE=~/.histfile
HISTSIZE=1
SAVEHIST=1
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
bindkey -e

export EDITOR=nvim
export VISUAL=nvim


# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
cat $HOME/.motd
source /etc/profile
exec fish
