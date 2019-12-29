#!/bin/sh
set -o errexit -o nounset

export RBENV_ROOT=/usr/local/var/rbenv
if command -v rbenv >/dev/null; then
    eval "$(rbenv init -)"
else
    echo >&2 "Error: rbenv not installed"
    exit 1
fi

echo "Updating Ruby"
rbenv install 2.6.5 --skip-existing
rbenv global 2.6.5
gem update --system
gem install pry rubocop
