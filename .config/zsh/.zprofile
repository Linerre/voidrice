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
export KERNEL_NAME=$( uname | tr '[:upper:]' '[:lower:]' )

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U path PATH
#path=(${path#/home/leon/node/node-v14.16.0-linux-x64/bin})

# user compiled python as default python
export PATH=$HOME/python/bin:$PATH
export PYTHONPATH=$HOME/python/

# user installed node as default node
export PATH="$HOME/node/node-v16.0.0-${KERNEL_NAME}-x64"/bin:$PATH
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

