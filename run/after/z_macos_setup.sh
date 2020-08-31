#!/bin/sh
set -o errexit -o nounset

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$(mktemp -d -t macos_setup_repos)"

trap 'rm -rf "$REPOS_DIR"' EXIT
(
    echo "Installing PAM Touch ID..."
    cd "$REPOS_DIR"
    set -x
    git clone https://github.com/Reflejo/pam-touchID.git
    cd pam-touchID
    sudo make install
    set +x

    cd -
    echo "Installing PAM Watch ID..."
    set -x
    git clone https://github.com/biscuitehh/pam-watchid.git
    cd pam-watchid
    sudo make install
    set +x
)

# Use a modified version of the Zenburn theme by default in Terminal.app
# Originally taken from https://github.com/bdesham/zenburn-terminal
echo "Setting default Terminal theme..."

open -a Terminal "$SCRIPT_DIR/../lib/assets/Zenburn.terminal"
sleep 2 # Wait a bit for theme to install.
osascript -e 'tell application "Terminal"' \
    -e 'set default settings to settings set "Zenburn"' \
    -e "close window 1" \
    -e "end tell"

echo "Updating Dock..."

dockutil --remove all --no-restart
dockutil --add /Applications/Alacritty.app --no-restart
dockutil --add /Applications/Emacs.app --no-restart
dockutil --add /Applications/Firefox.app --no-restart
dockutil --add ~/Downloads --display stack # Implicitly restarts the Dock.

echo "Updating default application handlers..."

set -x
duti -s org.gnu.Emacs com.apple.property-list all
duti -s org.gnu.Emacs com.apple.xcode.strings-text all
duti -s org.gnu.Emacs com.netscape.javascript-source all
duti -s org.gnu.Emacs net.daringfireball.markdown all
duti -s org.gnu.Emacs public.c-header all
duti -s org.gnu.Emacs public.c-plus-plus-source all
duti -s org.gnu.Emacs public.c-source all
duti -s org.gnu.Emacs public.comma-separated-values-text all
duti -s org.gnu.Emacs public.data all
duti -s org.gnu.Emacs public.json all
duti -s org.gnu.Emacs public.objective-c-source all
duti -s org.gnu.Emacs public.perl-script all
duti -s org.gnu.Emacs public.plain-text all
duti -s org.gnu.Emacs public.precompiled-c-header all
duti -s org.gnu.Emacs public.python-script all
duti -s org.gnu.Emacs public.ruby-script all
duti -s org.gnu.Emacs public.shell-script all
duti -s org.gnu.Emacs public.swift-source all
duti -s org.gnu.Emacs public.unix-executable all
duti -s org.gnu.Emacs public.xml all
duti -s org.gnu.Emacs public.yaml all
set +x

echo "Applying icons..."

if ! command -v chicon >/dev/null; then
    set -x
    brew install https://raw.githubusercontent.com/okdana/chicon/d602584/pkg/chicon.rb
    set +x
fi

chicon "$SCRIPT_DIR/../lib/assets/Alacritty.icns" /Applications/Alacritty.app
chicon "$SCRIPT_DIR/../lib/assets/Emacs.icns" /Applications/Emacs.app

echo "Installing custom utilities..."

"$SCRIPT_DIR/../lib/KeyBindings/install"
"$SCRIPT_DIR/../lib/LaunchTerm/install"

echo "Disabling netbiosd."
set -x
sudo launchctl disable system/netbiosd
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.netbiosd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist 2>/dev/null
