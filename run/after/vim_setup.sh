#!/bin/sh
set -o errexit -o nounset

VIM_DIR="$HOME/.vim"
VUNDLE_DIR="$VIM_DIR/bundle/Vundle.vim"

if [ ! -d "$VUNDLE_DIR" ]; then
    mkdir -p "$VIM_DIR/bundle"
    git clone https://github.com/gmarik/Vundle.vim.git "$VUNDLE_DIR"
fi

nvim +PluginUpdate +qall
