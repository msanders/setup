#!/bin/sh
set -o errexit -o nounset

if ! command -v stack >/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
fi

stack update
stack upgrade
stack install apply-refact hlint stylish-haskell hasktags hoogle
