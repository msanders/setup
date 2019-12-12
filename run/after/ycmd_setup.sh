#!/bin/sh
set -o errexit -o nounset

YCMD_DIR="$HOME/.ycmd"

if [ ! -d "$YCMD_DIR" ]; then
    git clone https://github.com/Valloric/ycmd.git "$YCMD_DIR"
fi

(
    cd "$YCMD_DIR"
    set -x
    git pull
    git submodule update --init --recursive
    ./build.py --clang-completer --java-completer --js-completer --rust-completer
    set +x
)

echo "Installed ycmd."
