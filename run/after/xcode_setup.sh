#!/bin/sh
set -o errexit -o nounset

REPO_DIR="$(mktemp -d -t san-jose-xcode-theme)"
trap 'rm -rf "$REPO_DIR"' EXIT
(
    cd "$REPO_DIR"
    git clone https://github.com/ornithocoder/san-jose-xcode-theme.git
    mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
    cp san-jose-xcode-theme/*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
)

echo "Installed San Jose Xcode theme."
