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

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# change Nodejs mirror
export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

# source  cargo only when rust was installed under $HOME
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"
