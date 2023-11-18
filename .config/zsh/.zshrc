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

# ============ ALIAS ==============
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
alias n="nix-shell"
alias m="mg -n"
alias l="ls -lh"

# ============ FUNCTION ==============
# Usage: wiki_info "page_title"
wiki_info() {
    local API_URL="https://en.wikipedia.org/w/api.php"
    local USR_AGT="Nobody/0.0.1 (Arch; Buu) Auto/0.0.1"
    local PAGE_TITLE="$1"
    curl -s "$API_URL" \
         -A "$USR_AGT" \
         --get \
         --data-urlencode "action=query" \
         --data-urlencode "format=json" \
         --data-urlencode "prop=revisions|info" \
         --data-urlencode "titles=$PAGE_TITLE" \
         --data-urlencode "formatversion=2" \
         --data-urlencode "rvprop=ids|timestamp" \
         --data-urlencode "rvlimit=2" \
         --data-urlencode "inprop=url" |
        jq -r '.'
}
