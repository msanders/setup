#!/bin/sh
set -o errexit -o nounset

export PATH="$HOME/.cargo/bin:$PATH"
COMPLETIONS_DIR="$HOME/.config/fish/completions"

if ! command -v rustup >/dev/null; then
    curl https://sh.rustup.rs -sSf | sh
fi

set -x
mkdir -p "$COMPLETIONS_DIR"
rustup default stable
rustup install nightly
rustup update
rustup completions fish >"$COMPLETIONS_DIR/rustup.fish"
rustup component add rust-src
rustup component add rustfmt

set +o errexit
cargo +nightly install racer
