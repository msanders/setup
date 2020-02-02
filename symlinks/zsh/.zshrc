# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# Colors
export CLICOLOR=1

# Prompt
PS1="%n:%1~ $ "

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1024
SAVEHIST=1024
HISTTIMEFORMAT="%F %T "

# Don't log commands beginning with a space.
setopt HIST_IGNORE_SPACE

# Ignore duplicates in history.
setopt HIST_SAVE_NO_DUPS

# Append to history on shell exit rather than overwrite.
setopt APPENDHISTORY

# Store history immediately rather than at end of session.
setopt INC_APPEND_HISTORY

# Allow comments like this in shell.
setopt INTERACTIVECOMMENTS

# Don't beep when auto-completing.
unsetopt LIST_BEEP

# Search history using C-p and C-n.
bindkey "" history-beginning-search-backward
bindkey "" history-beginning-search-forward
