#!/bin/sh
set -o errexit -o nounset

VIM_PLUG="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$VIM_PLUG" ]; then
    echo "Downloading vim-plug..."
    curl -#fLo "$VIM_PLUG" --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

nvim +PlugUpdate +PlugUpgrade +qall
