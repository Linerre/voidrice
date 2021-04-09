# ########################
# Environment variables  #
# ########################
#
export EDITOR=nvim
export PAGER=less
export ZDOTDIR=$HOME/.config/zsh
export XDG_CONFIG_HOME=$HOME/.config



# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path


# user compiled python as default python
export PATH=$HOME/python/bin:$PATH
export PYTHONPATH=$HOME/python/

# user installed node as default node
export PATH="$HOME/node/node-v14.16.0-linux-x64"/bin:$PATH
export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/
	

source "$HOME/.cargo/env"