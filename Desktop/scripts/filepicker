#!/usr/bin/env zsh
file2pick=$(fd --hidden --follow . "$HOME" | fzy -l 20 -p 'pick:' )

if [[ -z $file2pick ]]; then
    exit 0
elif [[ -f $file2pick ]]; then
    dragon-drop $file2pick
else
    exit 0
fi

