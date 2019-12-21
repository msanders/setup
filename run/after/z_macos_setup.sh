#!/bin/sh
set -o errexit -o nounset

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Disabling netbiosd."
set -x
sudo launchctl disable system/netbiosd
set +x

if [ ! -d "$HOME/iCloud" ]; then
    echo "Symlinking iCloud."
    set -x
    ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/" "$HOME/iCloud"
    set +x
else
    echo "iCloud directory already linked."
fi

# Use a modified version of the Zenburn theme by default in Terminal.app
# Originally taken from https://github.com/bdesham/zenburn-terminal
echo "Setting default Terminal theme..."

open -a Terminal "$SCRIPT_DIR/../lib/Zenburn.terminal"
sleep 2 # Wait a bit for theme to install.
osascript -e 'tell application "Terminal"' \
          -e 'set default settings to settings set "Zenburn"' \
          -e "close window 1" \
          -e "end tell"

echo "Updating Dock..."

dockutil --remove all --no-restart
dockutil --add /Applications/Firefox.app --no-restart
dockutil --add /Applications/Emacs.app --no-restart
dockutil --add /Applications/Utilities/Terminal.app --no-restart
dockutil --add ~/Downloads --display stack # Implicitly restarts the Dock.

echo "Installing custom utilities..."

"$SCRIPT_DIR/../lib/Grayscale/install"
"$SCRIPT_DIR/../lib/KeyBindings/install"
"$SCRIPT_DIR/../lib/LaunchTerm/install"

echo "Disabling netbiosd."
set -x
sudo launchctl disable system/netbiosd
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.netbiosd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist 2>/dev/null
