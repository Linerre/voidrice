#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TEST=$(uname -a)
[[ -d $HOME/.cargo ]] && . "$HOME/.cargo/env"
