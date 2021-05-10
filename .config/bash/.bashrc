#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# env
export PATH=$HOME/.local/bin:$PATH


# prompt
if [ $(whoami) = 'leon' ]; then
    PS1='  \w \$ '
else
    PS1='  \w \$ '
fi

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
