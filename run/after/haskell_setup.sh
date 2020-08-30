#!/bin/sh
set -o errexit -o nounset

if ! command -v stack >/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
fi

set +x
stack update
stack upgrade
stack install hoogle
set -x
