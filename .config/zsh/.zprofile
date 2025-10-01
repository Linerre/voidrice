# ########################
# Environment variables  #
# ########################
#
export EDITOR=emacs
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export NIX_CONF_DIR=${XDG_CONFIG_HOME} # not necessary indeed but I like it anyway
export KERNEL_NAME=$( uname | tr '[:upper:]' '[:lower:]' )
export PATH=$HOME/.local/bin:$PATH
export PROJECTS_HOME=$HOME/projects
# see https://docs.npmjs.com/cli/v6/using-npm/config#npmrc-files
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc


# fcitx5
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
if [ $XDG_SESSION_TYPE = x11 ]; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export INPUT_METHOD=fcitx
fi

# remove duplicate entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# change Nodejs mirror
# export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

# Cargo and Rust
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

# Haskell
[[ -d "$HOME/.ghcup"]] && export PATH="$HOME/.ghcup/bin:${PATH}"

# TexLive
LX_VER=2025
[[ -d "$HOME/.local/texlive/${LX_VER}" ]] && \
    { export PATH="$HOME/.local/texlive/${LX_VER}/bin/x86_64-linux:$PATH"
      export TEXLIVE_MAN="$HOME/.local/texlive/${LX_VER}/texmf-dist/doc/man"
      export TEXLIVE_INFO="$HOME/.local/texlive/${LX_VER}/texmf-dist/doc/info"
      export MANPATH="$TEXLIVE_MAN:$MANPATH"
      export INFOPATH="$TEXLIVE_INFO:$INFOPATH"
    }

# Solana
[[ -d "$HOME/.local/share/solana/" ]] && \
    export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# opam configuration
[[ ! -r /home/noel/.opam/opam-init/init.zsh ]] || source /home/noel/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# added by Nix installer
if [ -e /home/noel/.nix-profile/etc/profile.d/nix.sh ];
then
    . /home/noel/.nix-profile/etc/profile.d/nix.sh;
fi
