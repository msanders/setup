#!/bin/sh
set -o errexit -o nounset

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/"

echo "Installing Xcode theme..."
mkdir -p "$TARGET_DIR"
cp "$SCRIPT_DIR/../lib/assets/"*.xccolortheme "$TARGET_DIR"
echo "Successfully installed Xcode theme."
