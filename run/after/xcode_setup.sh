#!/bin/sh
set -o errexit -o nounset

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Xcode theme..."
cp "$SCRIPT_DIR/../lib/assets/"*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
echo "Successfully installed Xcode theme."
