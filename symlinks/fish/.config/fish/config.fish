set --export DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer"
set --export EDITOR "emacsclient --alternate-editor=vim"
set --export GITHUB_USERNAME msanders
set --export GREP_OPTIONS "--color=auto"
set --export LANG C
set --export LC_ALL en_US.UTF-8
set --export LSCOLORS cxfxexexexegedabagcxcx
set --export PATH "$HOME/bin" "$HOME/.local/bin" "/usr/local/bin" "/usr/local/sbin" $PATH
set --export fish_greeting
set --export theme_color_scheme zenburn
set __fish_git_prompt_show_informative_status 'yes'

if test -f $HOME/.aliases
    . $HOME/.aliases
end

if test -f $HOME/.secrets
    . $HOME/.secrets
end

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

# rbenv support
set -gx RBENV_ROOT /usr/local/var/rbenv
if which rbenv >/dev/null
    . (rbenv init - fish|psub)
end

# pyenv support
set --export PYENV_ROOT "$HOME/.pyenv"
set --export PATH "$PYENV_ROOT/bin" $PATH
if which pyenv >/dev/null
    mkdir -p "$PYENV_ROOT/bin"
    status --is-interactive; and . (pyenv init -|psub)
end

# Cask
set --export PATH "$HOME/.cask/bin" $PATH

set --local CARGO_PATH "$HOME/.cargo/bin"
if test -d $CARGO_PATH
    set --export PATH $CARGO_PATH $PATH
end

if which rustc > /dev/null
    set --export DYLD_LIBRARY_PATH (rustc --print sysroot)/lib $DYLD_LIBRARY_PATH
	set --export RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
end

# Add Postgres.app to PATH
set --export POSTGRES_DOT_APP "/Applications/Postgres.app"
if test -d "$POSTGRES_DOT_APP"
    set --export PATH "/Applications/Postgres.app/Contents/Versions/latest/bin" $PATH
end

function notify --description "Write message to system notification"
    if [ $argv ]; set --local message $argv; else; set message "Done running task"; end
    terminal-notifier -title "✅ Done" -message $message -timeout 5
end

function md --description "Make directory and switch to it"
    mkdir -p $argv && cd $argv
end

fish_hybrid_key_bindings
