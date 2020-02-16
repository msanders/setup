#!/bin/sh
#
# Smart confirm-before kill-pane command. Only asks for confirmation when
# killing a child process.
#
# See:
# https://posts.mksanders.org/simulating-macos-terminal-bindings-in-alacritty
set -o errexit -o nounset

tmux_run() (
    pane_pid="$(tmux list-panes -F "#{pane_active}:#{pane_pid}" |
        grep '^1:' |
        cut -c 3-)"
    escaped_cmd="$(echo "$*" | sed 's/;/\\\;/g')"
    if pgrep -P "$pane_pid" >/dev/null; then
        tmux confirm-before -p "kill-pane #P? (y/n)" "run 'tmux $escaped_cmd'"
    else
        tmux "$@"
    fi
)

main() (
    window_list="$(tmux list-windows -F '#{window_active}:#{window_panes}')"
    window_count="$(tmux display-message -p '#{session_windows}')"
    pane_count="$(echo "$window_list" |
        grep '^1:' |
        cut -c 3-)"

    # Mimic Terminal.app's behavior of always moving one tab to the right
    # unless at the end.
    if [ ! "$pane_count" = 1 ] || [ "$window_count" = 1 ]; then
        tmux_run kill-pane
    elif [ "$(echo "$window_list" | tail -n1 | cut -c1)" = 1 ]; then
        tmux_run previous-window\; next-window\; kill-pane
    else
        tmux_run next-window\; previous-window\; kill-pane
    fi
)

main
