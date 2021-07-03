autoload -Uz compinit promptinit
compinit
promptinit

prompt_mytheme_setup() {
        name='%F{red}%f%K{red} %n %k%F{red}%f'
        dir='%F{green}%f%K{green} %~ %k%F{green}%f'
        returncode='%(0?..%F{magenta}%f%K{magenta}  %k%F{magenta}%f)'
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
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
bindkey -e

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
export EDITOR=nvim
export VISUAL=nvim

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)

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
