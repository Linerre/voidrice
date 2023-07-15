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
hash -d proj=$HOME/projects
hash -d emd=$HOME/projects/emacs.d
hash -d dotf=$HOME/projetcs/voidrice/
hash -d bks=$HOME/Documents/books/

# plugins
autoload -Uz compinit promptinit
compinit
promptinit
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# direnv
eval "$(direnv hook zsh)"

# admin
alias doas=sudo
alias plz=sudo
alias ctl=systemctl

# moving
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# pacman
alias ps='pacman -Si'
alias ss='pacman -Ss'
alias pi='pacman -Qi'
alias up='sudo pacman -Syu'

# git
alias gt='git st'
alias gl='git log'
alias gw='git switch'
alias ga='git add'
alias gm='git cm'
alias gd='git diff'

# apps
alias e="emacs -nw"
alias za='zathura'
alias v="nvim"
alias n="nix-shell"
alias m="mg -n"
alias l="ls -lh"

# opam configuration
[[ ! -r /home/noel/.opam/opam-init/init.zsh ]] || source /home/noel/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

if [ -e /home/noel/.nix-profile/etc/profile.d/nix.sh ]; then . /home/noel/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
