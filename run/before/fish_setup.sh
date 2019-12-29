#!/bin/sh
set -o errexit -o nounset

OMF_DOWNLOAD_DIR="$(mktemp -d -t ohmyfish)"
trap 'rm -rf "$OMF_DOWNLOAD_DIR"' EXIT
(
    cd "$OMF_DOWNLOAD_DIR"
    echo "Downloading Oh My Fish..."
    curl --progress-bar -L https://get.oh-my.fish >install
    echo "Installing..."
    NONINTERACTIVE=true fish ./install --path=~/.local/share/omf --config=~/.config/omf --yes
)

fish -c "omf install bobthefish"
fish -c "omf install z"
