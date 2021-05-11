#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# env
export PATH=$HOME/.local/bin:$PATH


# prompt
if [ $(whoami) = 'leon' ]; then
    PS1='  \[\e[0;34m\w\e[0m \[\e[0;32m\$\e[0m '
else
    PS1='\[\e[0;34m \e[0m \[\e[1;31m\w \$\e[0m '
fi


# alias
alias ls='ls --color=auto'
alias rr='ranger'
alias bz="nvim $HOME/.bashrc"
alias bz="source $HOME/.bashrc"
alias nr="nvim $HOME/projetcs/nvim/init.vim"
alias nvr="nvim $HOME/.vim/vimrc"
