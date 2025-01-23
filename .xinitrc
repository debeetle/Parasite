#!/bin/sh

# if [ -f ~/.xmodmap ]; then
#     xmodmap ~/.Xmodmap
# fi

xrdb ~/.Xresources
# sudo systemctl --user import-environment DISPLAY
# xset r rate 200 40

# Statusbar loop
# while true; do
#    xsetroot -name "$( date +"%R" )"
#    sleep 1m    # Update time every minute
# done &

# feh --no-fehbg --bg-fill --random "/home/trunk/Desktop/wallpaper/"
# wget -O - -q reddit.com/r/earthporn.json | jq '.data.children[] |.data.url' | tail -6 | xargs feh --random --no-fehbg --bg-fill
# picom --config /home/trunk/picom.conf -b
# crond -f /home/trunk/Desktop/scron/schedule
# sxhkd &
# ibus-daemon -xd > /dev/null 2>&1
# fcitx5 &
#crond -f /home/trunk/Desktop/scron/schedule 

exec /usr/local/bin/dwm
# exec sxhkd
# exec /home/trunk/Desktop/scripts/restart_wm
# 2bwm &
