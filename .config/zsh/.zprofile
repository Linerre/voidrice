# ########################
# Environment variables  #
# ########################
#
export EDITOR=emacs
export PAGER=less
export ZDOTDIR=$HOME/projects/voidrice/.config/zsh
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export KERNEL_NAME=$( uname | tr '[:upper:]' '[:lower:]' )
export PATH=$HOME/.local/bin:$PATH
export PROJECTS_HOME=$HOME/projects
# see https://docs.npmjs.com/cli/v6/using-npm/config#npmrc-files
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc


# fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# change Nodejs mirror
export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

# source  cargo only when rust was installed under $HOME
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

# texlive
[[ -d "$HOME/.local/texlive/2022" ]] && \
    { export PATH="$HOME/.local/texlive/2022/bin/x86_64-linux:$PATH"
      export TEXLIVE_MAN="$HOME/.local/texlive/2022/texmf-dist/doc/man"
      export TEXLIVE_INFO="$HOME/.local/texlive/2022/texmf-dist/doc/info"
      export MANPATH="$TEXLIVE_MAN:$MANPATH"
      export INFOPATH="$TEXLIVE_INFO:$INFOPATH" 
    }

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
