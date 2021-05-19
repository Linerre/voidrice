#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# user vars
if [[ $(tty) != *'tty'* ]]; then
    if [[ $( cat /etc/os-release | head -1 ) =~ 'Arch' ]]; then
        distro=' '
    elif [[ $( cat /etc/os-release | head -1 ) =~ 'Gentoo' ]]; then
        distro=' '
    else
        distro=''
    fi
    # prompt for interactive Xorg shells
    if [ $(whoami) = 'leon' ]; then
        PS1=' \[\e[0;34m\]\w\[\e[0m\] \[\e[0;32m\]\$\[\e[0m\] '
    else
        PS1='\[\e[0;34m${distro}\]\[\e[0m\] \[\e[1;31m\]\w \$\[\e[0m\] '
    fi
else
    if [ $(whoami) = 'leon' ]; then
        PS1='[\[\e[0;32m\]\w\[\e[0m\] \[\e[0;35m\]\$\[\e[0m\]] '
    else
        PS1='\[\e[1;31m\]\h \w\[\e[0m\] '
    fi
fi


# env vars
export PATH=$HOME/.local/bin:$PATH




# alias
alias ls='ls --color=auto'
alias rr='ranger'
alias bz="nvim $HOME/.bashrc"
alias bz="source $HOME/.bashrc"
alias nr="nvim $HOME/projetcs/nvim/init.vim"
alias nvr="nvim $HOME/.vim/vimrc"
