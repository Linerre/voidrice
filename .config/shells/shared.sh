# ============ ENVS ==============
export EDITOR=emacs
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export NIX_CONF_DIR=${XDG_CONFIG_HOME} # not necessary indeed but I like it anyway
export KERNEL_NAME=$( uname | tr '[:upper:]' '[:lower:]' )
export PROJECTS_HOME=$HOME/projects
# see https://docs.npmjs.com/cli/v6/using-npm/config#npmrc-files
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc
HISTSIZE=2000
SAVEHIST=500
HISTIGNORE='sudo *'



# ============ PATH ==============
export PATH=$HOME/.local/bin:$PATH

# Cargo and Rust
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

# Haskell
[[ -d "$HOME/.ghcup" ]] && export PATH="$HOME/.ghcup/bin:${PATH}"

# TexLive
LX_VER=2025
[[ -d "$HOME/.local/texlive/${LX_VER}" ]] && \
    { export PATH="$HOME/.local/texlive/${LX_VER}/bin/x86_64-linux:$PATH"
      export TEXLIVE_MAN="$HOME/.local/texlive/${LX_VER}/texmf-dist/doc/man"
      export TEXLIVE_INFO="$HOME/.local/texlive/${LX_VER}/texmf-dist/doc/info"
      export MANPATH="${TEXLIVE_MAN}:${MANPATH}"
      export INFOPATH="${TEXLIVE_INFO}:${INFOPATH}"
    }

# Solana
[[ -d "$HOME/.local/share/solana/" ]] && \
    export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# added by Nix installer
if [ -e /home/noel/.nix-profile/etc/profile.d/nix.sh ];
then
    . /home/noel/.nix-profile/etc/profile.d/nix.sh;
fi

# ============ FCITX5 ==============
# fcitx5
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
if [ $XDG_SESSION_TYPE = x11 ]; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export INPUT_METHOD=fcitx
fi

# ============ ALIAS ==============
# admin
alias doas=sudo
alias plz=sudo
alias ctl=systemctl

# moving
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
alias l="ls -lh --group-directories-first -S"
alias l1="eza -1"
alias ll="eza -lha --group-directories-first --sort size"
alias pn="stat --format '%A %a %U %G'"

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

# Usage: ytm <URL>
ytm() {
    local DEST="$HOME/Music/ost"
    local MUSIC_SRC="$1"
    [[ ! -d "$DEST" ]] && mkdir "$DEST"
    yt-dlp --extract-audio --audio-format mp3 \
           --path "$DEST" \
           --output "%(title)s.%(ext)s" "$MUSIC_SRC"
}

clean_sceenshots()
{
    echo -n "You are going to delete all the screenshots? [y/n] "
    read -r resp
    [[ ${resp} == 'y' ]] && rm ~/Pictures/screenshots/*.png || echo "Action canceled."
}

wrap_longpath()
{
    # Match a path part like `/path_part-or-part', 5 times or more
    if [[ $(pwd) =~ (/[[:alnum:]_-]+){5,} ]]; then
        PS1='[\[\e[0;31m\]H\[\e[0m\]] \[\e[0;34m\]\w\[\e[0m\]\n\[\e[0;32m\]\$\[\e[0m\] '
    else
        PS1='[\[\e[0;31m\]H\[\e[0m\]] \[\e[0;34m\]\w\[\e[0m\] \[\e[0;32m\]\$\[\e[0m\] '
    fi
}
