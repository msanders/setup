export EDITOR=em
export PATH="$HOME/bin:$PATH"
export PS1="%n:%1~ $ "

setopt NOMATCH # If glob shows no matches, tell me.
setopt INTERACTIVECOMMENTS # Allow comments like this in shell.
setopt MENU_COMPLETE # Display menu for ambiguous completions.

unsetopt LIST_BEEP # Don't beep when auto-completing.
unsetopt CASE_GLOB # Ignore case in completions.
unsetopt EXTENDED_GLOB # Do not treat #, ^ and ~ as parts of patterns.

# Encoding
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Colors
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=cxfxexexexegedabagcxcx

# Append to history on-the-fly (not just on exit).
setopt APPENDHISTORY INC_APPEND_HISTORY

# Ignore duplicates in history.
setopt HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_ALL_DUPS 

# Don't log commands beginning with a space.
setopt HIST_IGNORE_SPACE

bindkey '^[[Z' reverse-menu-complete # Shift-tab to go back an item in menu.
bindkey " " magic-space # Expand variables such as !$ when space is pressed.

# Search history using  & .
bindkey "" history-beginning-search-backward
bindkey "" history-beginning-search-forward

# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

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
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Cask
export PATH="$HOME/.cask/bin:$PATH"

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"
