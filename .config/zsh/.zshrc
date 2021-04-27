###########################
# Zshrc 0.0.1
# by Errelin
###########################

# source $ZDOTDIR/.zprofile; see comments there for why
# on macOS, always login, thus it is $ZDOTDIR/.zprofile itself instead
# on Linux this is always sourced since terminal is interactive
ZPROFILE="$HOME/.config/zsh/.zprofile"
if [[ -f $ZPROFILE ]]; then
    source $ZPROFILE
else
    echo '.zprofile not found; $PATH may not be set properly.'
fi

# prompt
if [ $(whoami) = 'leon' ]; then
	PS1="%F{magenta}> %f"
    PS2="%F{yellow}>> %f"
    RPS1="%(?..(%?%)) %B%F{lightgreen}%3c %f%b"
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

# filter history 
alias hg='history | grep -i'

# Utilities
alias sx="startx"

# open programms
alias v="nvim"
alias n="nvim"
alias rr="ranger"
alias em="emacs -nw"
# pacman or xbps
if [ -d /etc/xbps.d ]; then
		alias xi="sudo xbps-install -S"
		alias xu="sudo xbps-install -Su"
		alias xr="sudo xbps-remove -R"
		alias xq="xbps-query -R"
		alias xql="xbps-query -l"

fi

if [ -d /etc/pacman.d ]; then
		alias pi="sudo pacman -S"
		alias pu="sudo pacman -Sy"
		alias pr="sudo pacman -Rns"
		alias ps="pacman -Ss"
		alias psq="pacman -Qi"
fi

# open, source dotfiles 
alias nz="nvim $ZDOTDIR/.zshrc"
alias ne="source $ZDOTDIR/.zshenv"
alias sz="source $ZDOTDIR/.zshrc"
alias nr="nvim ~/.config/nvim/init.vim"
alias nvr="nvim ~/.vimrc"

# cmd shorthands
case $KERNEL_NAME in
    'linux')
        alias ls="ls --color=auto"
        alias ll="ls -alh"
        alias la="ls -a"
        alias lla="ls -alhF"
        ;;
    'darwin')
        alias ls="ls -G"
        alias ll="ls -alh"
        alias la="ls -a"
        alias lla="ls -alhF"
        ;;

#alias logout="pkill -KILL -u leon"

# git
#alias pa="git push origin main"


# texlive
# alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode' 

# dropbox
alias dropsync="dropbox.py start"
alias dropshut="dropbox.py stop"
alias dropst="dropbox.py status"

alias za='zathura'
