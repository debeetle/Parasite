#!/usr/bin/bash
DefaultSavePath="$HOME/capture/$(date +%m_%d_%y_%T).png"

coordinate=$(slurp) || exit
grim -l 0 -g "$coordinate" || exit

# SavePath=$(
zenity --file-selection --save --filename="$DefaultSavePath" || exit
# ) || exit
# --file-filter=*.png \

# case "$SavePath" in
# *.png) ;;
# *) SavePath="$SavePath.png" ;;
# esac
#
# [[ $SavePath =~ \.png$ ]] || SavePath+='.png'
