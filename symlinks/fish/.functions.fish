function notify --description "Write message to system notification"
    set --local message
    if [ $argv ]; set message $argv; else; set message "Done running task"; end
    terminal-notifier -title "✅ Done" -message $message -timeout 5
end

function md --description "Make directory and switch to it"
    mkdir -p $argv && cd $argv
end

# From https://stackoverflow.com/a/39891882
function read_confirm --description "Ask user for a confirmation" --argument prompt
    if test -z "$prompt"
        set prompt "Continue?"
    end

    while true
        read -P "$prompt [y/N]: " -l confirm
        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end


function rm_ds_store --description "Remove .DS_Store files recursively from a directory" \
                     --argument dir
    set --local files (fd --hidden '^\.DS_Store$' --no-ignore $dir)
    if test -n "$files"
        echo "Found $files"
        if read_confirm "Remove files?"
            rm $files
        end
    else
        echo "No .DS_Store files found."
    end
end
