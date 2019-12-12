#!/bin/sh
set -o errexit -o nounset

EMACS_DIR="$HOME/.emacs.d"

if [ ! -d "$EMACS_DIR" ]; then
    git clone https://github.com/syl20bnr/spacemacs "$EMACS_DIR"
    echo "Installed Spacemacs."
fi

if [ ! -d "$HOME/.cask" ]; then
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
fi
