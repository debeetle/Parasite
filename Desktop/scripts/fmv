#!/usr/bin/zsh
candidate=$(fd --hidden --follow . "$HOME" | fzf --height=60% --preview 'pv {}')

if [[ -z $candidate ]]; then
    exit
else
    targetdir=$(fd -td --hidden --follow . "$HOME" | fzf --height=60% --preview 'pv {}')
    mv -i $candidate $targetdir
fi
