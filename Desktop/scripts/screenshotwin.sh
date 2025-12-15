#!/bin/dash

# Get client info
read -r PID
read -r TITLE
read -r APPID
read -r TAGS
read -r GEOMETRY

[ -n "$GEOMETRY" ] || exit 1

tempdir="/home/chaos/capture"
# mkdir -p "$tempdir"
file="$(mktemp -p "$tempdir" "XXXXXX.png")"

# Grab the screenshot! Very conviniently, GEOMETRY format matches the one
# expected by grim

# without border
# grim -g "$GEOMETRY" "$file" || exit

# with border
# 计算带边框的新坐标和尺寸
eval "$(echo "$GEOMETRY" | awk -F'[,x ]' '{printf "x=%s\ny=%s\nwidth=%s\nheight=%s", $1, $2, $3, $4}')"
border=2  # 边框大小
new_x=$((x - border))
new_y=$((y - border))
new_width=$((width + 2 * border))
new_height=$((height + 2 * border))

NEWGEOMETRY="${new_x},${new_y} ${new_width}x${new_height}"
grim -l 0 -g "$NEWGEOMETRY" "$file" || exit

# wl-copy -t image/png < "$file"
# notify-send -i "$file" "Screenshot taken!" "Image copied to clipboard and saved to $file"

