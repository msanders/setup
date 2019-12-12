# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return;
fi

# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.aliases"
fi

export PS1='\u:\W $ '

# Encoding
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Colors
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=cxfxexexexegedabagcxcx

# History
export HISTCONTROL=erasedups,ignorespace
export HISTSIZE=1000

# Append to history on shell exit rather than overwrite.
shopt -s histappend
