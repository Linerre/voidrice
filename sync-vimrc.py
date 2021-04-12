# -*- encoding: utf-8 -*-

# This script will sync changes for the following paired directories:
# $dotfiles/.config/vim --> C:\Users\<username>\vimfiles 
# $dotfiles/.config/nvim --> C:\Users\<username>\AppData\Local\nvim

import os
import os.path
import filecmp
import difflib

# target vim dir path/vimrc
vimrc_targ_dir = os.path.join(os.environ['USERPROFILE'], 'voidrice/.config/vim') 
vimrc_targ = os.path.join(vimrc_targ_dir, 'vimrc')


# destination dir path/gvimrc
vimrc_dest_dir = os.path.join(os.environ['USERPROFILE'], 'vimfiles')
vimrc_dest = os.path.join(vimrc_dest_dir, 'gvimrc')


# target nvim dir path/init.vim
# NVIMRC_TARG_DIR = os.path.join(os.environ['USERPROFILE'], 'voidrice/.config/nvim')
# NVIMRC_DEST_DIR = os.path.join(os.environ['USERPROFILE'], 'AppData\\Local\\nvim')


if __name__ == '__main__':
    print('Files identical? ', filecmp.cmp(vimrc_targ, vimrc_dest))
