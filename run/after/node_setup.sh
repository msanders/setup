#!/bin/sh
set -o errexit -o nounset

echo "Updating npm dependencies."
if [ "$(uname -s)" = "Darwin" ]; then
    npm install -g elm-live
    npm install -g typescript tern
    npm install -g ios-deploy
else
    sudo npm install -g typescript tern

    # Workaround from https://github.com/elm-lang/elm-platform/issues/236#issuecomment-402565715
    sudo npm install -g elm elm-format elm-live --unsafe-perm=true --allow-root
fi
