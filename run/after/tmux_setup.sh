#!/bin/sh
set -o errexit -o nounset

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
