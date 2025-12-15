#!/usr/bin/env dash
DefaultSaveDir="~/capture"

coordinate=$(slurp) || exit
grim -l 0 -g "$coordinate" || exit

SavePath=$( zenity \
    --file-selection \
    --save \
    # --file-filter=*.png \
    --filename="$DefaultSaveDir" \
) || exit

case "$SavePath" in
    *.png) ;;
    *) SavePath="$SavePath.png" ;;
esac
# [[ $SavePath =~ \.png$ ]] || SavePath+='.png'
