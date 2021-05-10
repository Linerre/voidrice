#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# env
export PATH=$HOME/.local/bin:$PATH


# prompt
PS1='  \w \$ '
#PS1='  \w \$ '


# alias
alias ls='ls --color=auto'
alias rr='ranger'
#PS1='[\u@\h \W]\$ '
