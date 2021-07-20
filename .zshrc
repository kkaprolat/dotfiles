autoload -Uz compinit promptinit
compinit
promptinit

prompt_mytheme_setup() {
        name='%F{red}%f%K{red} %n %k%F{red}%f'
        dir='%F{yellow}%f%K{yellow}%F{black} %~ %f%k%F{yellow}%f'
        returncode='%(0?..%F{magenta}%f%K{magenta}  %k%F{magenta}%f)'
        PS1=' '
        PS1=$name
        PS1+=' '
        PS1+=$dir
        PS1+=' '
        PS1+=$returncode
        PS1+=' '
}
prompt_themes+=( mytheme )
prompt mytheme

zstyle ':completion:*' menu select # arrow key driven interface
zstyle :compinstall filename '/home/kay/.zshrc'
setopt COMPLETE_ALIASES # autocompletion of command line switches
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
bindkey -e

# see https://superuser.com/a/585004
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
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
alias ls="ls -lAh --color"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vim='nvim'
alias vi='nvim'
alias sudo='sudo ' # so that aliases are applied when using sudo
alias diff='diff --color=auto'
alias grep='grep --color=auto'
cat $HOME/.motd | lolcat -t
