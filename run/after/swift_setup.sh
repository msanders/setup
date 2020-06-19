#!/bin/sh
set -o errexit -o nounset

TOOLCHAIN_NAME="swift-5.2.4"
TOOLCHAIN_DIR="$(mktemp -d -t $TOOLCHAIN_NAME)"

trap 'rm -rf "$TOOLCHAIN_DIR"' EXIT
(
    echo "Installing Swift toolchain..."
    echo "Downloading $TOOLCHAIN_NAME-RELEASE-osx.pkg..."
    cd "$TOOLCHAIN_DIR"
    curl --location --progress-bar \
        "https://swift.org/builds/$TOOLCHAIN_NAME-release/xcode/$TOOLCHAIN_NAME-RELEASE/$TOOLCHAIN_NAME-RELEASE-osx.pkg" \
        --output "$TOOLCHAIN_DIR/$TOOLCHAIN_NAME.pkg"
    sudo installer -pkg "$TOOLCHAIN_DIR/$TOOLCHAIN_NAME.pkg" -target /
    echo "Successfully installed $TOOLCHAIN_NAME toolchain"
)
