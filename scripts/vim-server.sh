#!/bin/sh

if [ $# -eq 0 ]
then
    vim --servername vim
else
    vim --servername vim --remote-silent $*
fi

