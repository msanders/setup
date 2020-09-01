# Checking for login status here allows for faster start times when using tmux.
# See:
# - https://posts.mksanders.org/instant-pyenv-rbenv-startup-times-with-tmux
# - https://posts.mksanders.org/faster-fish-startup-times
if status is-login
    # pyenv
    if command -v pyenv >/dev/null
        pyenv init - --no-rehash fish | source
        and funcsave pyenv
        and sh -c 'pyenv rehash 2>/dev/null &'
    end

    # rbenv
    if command -v rbenv >/dev/null
        rbenv init - --no-rehash fish | source
        and funcsave rbenv
        and sh -c 'rbenv rehash 2>/dev/null &'
    end

    set --export DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer"
    set --export EDITOR "emc"
    set --export GTAGSLABEL "pygments"
    set --export HOMEBREW_AUTO_UPDATE_SECS 86400
    set --export LANG en_US.UTF-8
    set --export LANGUAGE en_US.UTF-8
    set --export LC_ALL en_US.UTF-8
    set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set --export PATH "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.cask/bin" \
                      "$HOME/.emacs.d/bin" "/usr/local/opt/emacs-mac/bin" $PATH
    set --export PYENV_ROOT "$HOME/.pyenv"
    set --export SHELLCHECK_OPTS "--external-sources"

    if status is-interactive
        if test -f $HOME/.aliases
            source $HOME/.aliases

            # Export aliases for lazy-loading in child shells.
            for alias in (rg -o "^alias \b\w+\b" $HOME/.aliases | cut -c 7-)
                funcsave $alias
            end
        end

        if test -f $HOME/.functions.fish
            source $HOME/.functions.fish

            # Export functions for lazy-loading in child shells.
            for func in (rg -o "function \b\w+\b" $HOME/.functions.fish | cut -c 10-)
                funcsave $func
            end
        end

        # Enable hybrid vi/emacs bindings.
        if ! test "$fish_key_bindings" = "fish_hybrid_key_bindings"
            fish_hybrid_key_bindings
        end
    end
end

if status is-interactive
    # Disable greeting.
    set --export fish_greeting
    function fish_greeting; end

    # Use fd to leave insert mode.
    function fish_user_key_bindings
        bind -M insert -m default fd backward-char force-repaint
    end

    # Disable dated history in bobthefish prompt.
    set -g theme_display_date no

    # Apply theme.
    set --export theme_color_scheme zenburn
    set fish_color_normal normal
    set fish_color_command ffd700
    set fish_color_quote normal
    set fish_color_redirection normal
    set fish_color_end ffffff
    set fish_color_error ff5f5f --bold
    set fish_color_param ffff5f
    set fish_color_comment 87ffff
    set fish_color_match cyan
    set fish_color_search_match ffffff --background=005f00
    set fish_color_operator cyan
    set fish_color_escape cyan
    set fish_color_cwd green
end
