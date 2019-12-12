export EDITOR="em"
export PATH="$HOME/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if command -v rbenv 1>/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Rustup
if command -v rustc; then
    export PATH="$HOME/.cargo/bin:$PATH"
    export RUST_SRC_PATH
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Cask
export PATH="$HOME/.cask/bin:$PATH"

# Add Postgres.app to PATH
export POSTGRES_DOT_APP="/Applications/Postgres.app"
if [ -d "$POSTGRES_DOT_APP" ]; then
    export PATH=$PATH:"$POSTGRES_DOT_APP/Contents/Versions/9.3/bin"
fi

export GTAGSLABEL=pygments

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
# shellcheck source=/dev/null
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/travis/travis.sh"
