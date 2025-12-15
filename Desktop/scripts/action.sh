#!/usr/bin/dash
# set -eu -o pipefail
choice=$(pmenu "brightness" "lock" "logout" "reboot" "shutdown" "suspend" "hibernate" "volumn")
# choice=$(printf "brightness\nlock\nlogout\nreboot\nshutdown\nvolumn" | fzy -p '')

case "$choice" in
lock)
	# exec setsid waylock -log-level error -fork-on-lock -ignore-empty-password -init-color 0x111111 -input-color 0x587539 -fail-color 0xf52a65 > /dev/null #&  ##0xffb86c
	exec setsid wlock -c 111111 -i 587539 -f f52a65 #&  ##0xffb86c
	doas /usr/bin/systemctl -f -q suspend-then-hibernate
	;;
shutdown)
	doas /usr/bin/shutdown -h now
	;;
reboot)
	doas /usr/bin/reboot
	;;
logout)
	pkill dwl
	;;
suspend)
	doas /usr/bin/systemctl -f -q suspend-then-hibernate
	;;
volumn)
	echo volumn
	;;
esac
