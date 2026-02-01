#!/usr/bin/env dash
systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP

# /usr/bin/foot --server --log-no-syslog --log-level=none &
# /usr/bin/emacs --daemon >/dev/null 2>&1
/opt/fasthome/garden/scripts/toggletheme.sh &
# busybox httpd -p 8081 -h /home/chaos/garden/web/startpage/

systemctl --user start foot-server
# /usr/bin/fcitx5 >/dev/null &

# darkhttpd /home/chaos/garden/web/startpage/ --port 8082 --daemon
# python -m http.server -d ~/garden/web/startpage 8081 >/dev/null &
# doas quark -p 8082 -h 192.168.1.190 -u chaos -g chaos -d /home/chaos/garden/web/startpage
exec <&-
