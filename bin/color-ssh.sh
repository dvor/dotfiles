#/bin/bash

change_iterm_profile() {
    echo -e "\033]50;SetProfile=$1\a"
}

finish() {
    change_iterm_profile "Default"
}

trap finish INT EXIT

change_iterm_profile "ssh"
ssh $@
