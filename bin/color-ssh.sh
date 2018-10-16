#/bin/bash

function change_iterm_profile() {
  echo -e "\033]50;SetProfile=$1\a"
}


change_iterm_profile "ssh"

ssh $@

change_iterm_profile "Default"
