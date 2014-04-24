tell application "iTerm"
    activate
    set myterm to (current terminal)

    try
        get myterm
    on error
        -- if there's no terminal, create a new one
        set myterm to (make new terminal)
    end try

    tell myterm

        -- trying to find previous ranger session and switch to it
        repeat with mysession in sessions
            tell mysession
                set the_name to get name
                if the_name contains "Ranger" then
                    select mysession
                    return
                end if
            end tell
        end repeat

        -- it seems, that there's no ranger session, creating a new one
        set mysession to (make new session at the end of sessions)
        tell mysession
            set name to "Ranger"
            --exec command "/bin/bash -l"
            exec command "/bin/bash -l /usr/local/bin/ranger"
        end tell
    end tell
end tell


