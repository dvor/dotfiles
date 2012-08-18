#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls --color=auto'
alias v='~/dotfiles/scripts/./vim-server.sh'

PS1='[\u@\h \W]\$ '

if [ -f /etc/bash_completion ]; then

	. /etc/bash_completion

fi

