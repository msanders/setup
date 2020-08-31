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

echo "Updating Dock..."

set -x
dockutil --remove all --no-restart
dockutil --add /Applications/Firefox.app --no-restart
dockutil --add /Applications/Emacs.app --no-restart
dockutil --add /Applications/Alacritty.app --no-restart
dockutil --add ~/Downloads --display stack # Implicitly restarts the Dock.
set +x

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

(
    cd "$SCRIPT_DIR/../lib"

    echo "Adding Terminal theme..."
    if ! defaults read com.apple.Terminal "Window Settings" | grep -Fw Zenburn >/dev/null; then
        open -a Terminal assets/Zenburn.terminal
    fi

    echo "Applying icons..."
    ./set-icon assets/Alacritty.icns /Applications/Alacritty.app
    ./set-icon assets/Emacs.icns /Applications/Emacs.app

    echo "Installing custom utilities..."
    ./KeyBindings/install
    ./LaunchTerm/install
)

echo "Adding applications to Gatekeeper whitelist..."
(while read -r app; do
     spctl --remove "$app" 2>/dev/null ||:
     spctl --add "$app"
     echo "Whitelisted $app."
 done) <<-EOF
	/Applications/Alacritty.app
	/Applications/Chromium.app
	/Applications/Pine.app
	$HOME/Library/QuickLook/Pacifist.qlgenerator
	$HOME/Library/QuickLook/QLColorCode.qlgenerator
	$HOME/Library/QuickLook/QLStephen.qlgenerator
EOF

echo "Resetting QuickLook."
set -x
qlmanage -r
qlmanage -r cache
killall Finder
set +x

echo "Disabling Homebrew analytics."
set -x
brew analytics off
set +x

echo "Disabling netbiosd."
set -x
sudo launchctl disable system/netbiosd
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.netbiosd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist 2>/dev/null
set +x
