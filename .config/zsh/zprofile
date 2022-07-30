# accasionally I need arch to be a server 
# so I'll start x with startx instead
# autostart x session
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -le 3 ]; then
#   exec startx
# fi

# ########################
# Environment variables  #
# ########################
#
export EDITOR=nvim
export PAGER=less
export ZDOTDIR=$HOME/.config/zsh
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export KERNEL_NAME=$( uname | tr '[:upper:]' '[:lower:]' )
export JAVA_HOME="$HOME/.local/jdk-17.jdk/Contents/Home"
export MAVEN_HOME="$HOME/.local/apache-maven-3.8.2/bin"
export PATH=$HOME/.local/bin:${JAVA_HOME}:${MAVEN_HOME}:$PATH
export PROJECTS_HOME=$HOME/projects
# see https://docs.npmjs.com/cli/v6/using-npm/config#npmrc-files
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path 

# ~/.local/bin analogous to /usr/local/bin
export PATH=${HOME}/.local/bin:${JAVA_HOME}:${MAVEN_HOME}:${PATH}:${HOME}/Library/Python/3.9/bin

# user compiled python as default python
# export PYTHONPATH=$HOME/python/

# change Nodejs mirror 
export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

# source  cargo only when rust was installed under $HOME
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

# added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi 
