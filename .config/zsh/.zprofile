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

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path 

# ~/.local/bin analogous to /usr/local/bin
export PATH=$HOME/.local/bin:$PATH

# user compiled python as default python
export PYTHONPATH=$HOME/python/

# change Nodejs mirror 
export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/

	
case $KERNEL_NAME in
    'linux')
        source "$HOME/.cargo/env"
        ;;
    'darwin')
        export PATH="/opt/local/bin:/opt/local/sbin":$PATH
        ;;
    *) ;;
esac
