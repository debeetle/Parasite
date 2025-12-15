#!/usr/bin/dash

systemctl --user set-environment "WAYLAND_DISPLAY=${WAYLAND_DISPLAY}" "XDG_CURRENT_DESKTOP=${XDG_CURRENT_DESKTOP:-sway:wlroots}"
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP
# dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway

/usr/bin/foot --server --log-no-syslog &
/usr/bin/fcitx5 -d &
/opt/fasthome/garden/scripts/toggletheme.sh
python -m http.server -d ~/garden/web/startpage 8081 >/dev/null 2>&1 &
# doas quark -p 8082 -h 192.168.1.190 -u chaos -g chaos -d /home/chaos/garden/web/startpage
