#!/bin/bash

dir="./"

if [ ! -z $1 ]; then
    dir=$1
fi

workspaces=`ls $dir | grep xcworkspace`

if [ -z "$workspaces" ]; then
    echo "No xcworkspace's found in directory $dir"
    exit 0
fi

if [ `echo "$workspaces" | wc -l` -eq 1 ]; then
    space=$workspaces
else
    echo "Available xcworkspaces:"
    echo "$workspaces" | nl
    printf "Select xcworkspace> "

    read num

    space=`echo "$workspaces" | sed -n ${num}p`
fi

open $dir$space
