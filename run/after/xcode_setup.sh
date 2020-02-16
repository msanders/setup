#!/bin/sh
set -o errexit -o nounset

TOOLCHAIN_NAME="swift-5.1.4"
REPO_DIR="$(mktemp -d -t san-jose-xcode-theme)"
TOOLCHAIN_DIR="$(mktemp -d -t $TOOLCHAIN_NAME)"
trap 'rm -rf "$TOOLCHAIN_DIR" "$REPO_DIR"' EXIT

install_theme() (
    echo "Installing Xcode theme..."
    cd "$REPO_DIR"
    git clone https://github.com/ornithocoder/san-jose-xcode-theme.git
    mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
    cp san-jose-xcode-theme/*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
    echo "Successfully installed San Jose Xcode theme."
)

install_toolchain() (
    echo "Installing Swift toolchain..."
    echo "Downloading $TOOLCHAIN_NAME-RELEASE-osx.pkg..."
    cd "$TOOLCHAIN_DIR"
    curl --location --progress-bar \
        "https://swift.org/builds/$TOOLCHAIN_NAME-release/xcode/$TOOLCHAIN_NAME-RELEASE/$TOOLCHAIN_NAME-RELEASE-osx.pkg" \
        --output "$TOOLCHAIN_DIR/$TOOLCHAIN_NAME.pkg"
    sudo installer -pkg "$TOOLCHAIN_DIR/$TOOLCHAIN_NAME.pkg" -target /
    echo "Successfully installed $TOOLCHAIN_NAME toolchain"
)

install_theme
install_toolchain
