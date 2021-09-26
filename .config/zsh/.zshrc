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
    echo ".zprofile not found; $PATH may not be set properly."
fi

# prompt
if [ $(whoami) = 'leon' ] || [ $(whoami) = 'errenil' ]; then
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

# open programms
alias v="nvim"
alias n="nvim"
alias rr="ranger"

# open, source dotfiles 
alias nz="nvim $ZDOTDIR/.zshrc"
alias sz="source $ZDOTDIR/.zshrc"
# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias
#alias ls='ls --color=auto' # NOTE: not posix
alias rr='ranger'
alias bz="nvim $HOME/.bashrc"
alias bz="source $HOME/.bashrc"
alias nr="nvim $HOME/projetcs/nvim/init.vim"
alias nvr="nvim $HOME/.vim/vimrc"
alias nr="nvim $HOME/projetcs/nvim/init.vim"
alias nvr="nvim $HOME/.vim/vimrc"

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
	#alias emacs="$HOME/projects/emacs-src/src/emacs -nw"
        ;;
esac

# texlive
# alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode' 

# dropbox
alias dropsync="dropbox.py start"
alias dropshut="dropbox.py stop"
alias dropst="dropbox.py status"

alias za='zathura'
