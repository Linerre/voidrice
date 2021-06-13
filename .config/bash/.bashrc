#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# user vars
# prompt for X sessions with glyphs (icons) from nerd fonts
#if [[ $(tty) != *'tty'* ]] && [[ $(tty) != *'pts'* ]]; then
# non-login, interactive shell
#if [[ $(echo $0) != '-'* ]]; then
if [[ $(echo $TERM) != 'linux' ]] && [[ $(tty) != *'pts'* ]]; then 
    # this could be st-256color or xterm-256color
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
# prompt for login, interactive shell 
else
    if [ $(whoami) = 'leon' ]; then
        PS1='[\[\e[0;32m\]\h: \w\[\e[0m\] \[\e[0;35m\]\$\[\e[0m\]] '
    else
        PS1='\[\e[1;31m\]\h \w\[\e[0m\] '
    fi
fi


# env vars
export PATH=$HOME/.local/bin:$PATH
export PROJECTS_HOME=$HOME/projects

# source  cargo only when rust was installed under $HOME
[[ -d $HOME/.cargo ]] && . "$HOME/.cargo/env"

# alias
alias ls='ls --color=auto' # NOTE: not posix
alias rr='ranger'
alias bz="nvim $HOME/.bashrc"
alias bz="source $HOME/.bashrc"
alias nr="nvim $HOME/projetcs/nvim/init.vim"
alias nvr="nvim $HOME/.vim/vimrc"
