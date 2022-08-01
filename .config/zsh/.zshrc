###########################
# Zshrc 0.0.1
# by Errelin
###########################
# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
if [ $(whoami) = 'noel' ] ; then
	 PS1="%F{magenta}> %f"
   PS2="%F{yellow}>> %f"
   RPS1="%(?..%F{red}(%?%))%f %B%F{green}%3c %f%b"
else
   PS1="%F{red}%n%f %~ "
   PS2="%F{yellow}>> %f"
   RPS1="%(?..(%?%))"
fi

# options
setopt AUTO_CD
setopt HIST_VERIFY

# keybindings
bindkey -e

# Hash
hash -d dotfiles=$HOME/projetcs/voidrice/
hash -d suckless=$HOME/projetcs/suckless/
hash -d bks=$HOME/Documents/books/


# moving
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


alias e="emacs -nw"
alias za='zathura'
