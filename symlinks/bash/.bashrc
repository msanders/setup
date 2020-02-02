# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.aliases"
fi

# Colors
export CLICOLOR=1

# Prompt
PS1='\u:\W $ '

# History
HISTCONTROL=ignoreboth
HISTSIZE=1024
HISTTIMEFORMAT="%F %T "

# Store history immediately rather than at end of session.
PROMPT_COMMAND="history -a"

# Append to history on shell exit rather than overwrite.
shopt -s histappend

# Adjust saved commands to fit on one line.
shopt -s cmdhist
