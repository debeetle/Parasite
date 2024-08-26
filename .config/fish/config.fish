#!/usr/bin/env fish

set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x GOPATH $XDG_DATA_HOME/go
set -x KERAS_HOME $XDG_STATE_HOME/keras

function fishsun
	set -l hour (date +%H)
	if test $hour -gt 16 -o $hour -lt 05
		echo "y" | fish_config theme save Dracula
	else
		echo "y" | fish_config theme save Tomorrow
	end
end

if status is-interactive
	abbr -a of " of"
	abbr -a pain " pain"
	abbr -a parm " parm"
	abbr -a ip "ip -color=auto"
	abbr -a diff "diff --color=auto"
	abbr -a grep "grep --color=auto"
	abbr -a dir "emacs -nw ."
	abbr -a wget "wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"
	abbr -a fixcp "echo (command wl-paste) | python /home/trunk/Desktop/scripts/no-double-col.py | wl-copy"
    abbr -a windown "virsh shutdown win11 > /dev/null"
	# abbr -a huan "wget -O - -q reddit.com/r/wallpaper.json | jq '.data.children[] |.data.url' | tail -6 | xargs feh --no-fehbg --bg-fill --random"
	# abbr --add nuc 'a602@10.168.38.7'
end

if status is-login
    fishsun
    # /usr/local/bin/crond -f /home/trunk/Desktop/scron/must_cron
	# exec bash -c "test -e /etc/profile && source /etc/profile;\
	# exec  fish"
    # VBoxHeadless --startvm openwrt > /dev/null 2>&1
end

function pain 
	set -l res $(pacman --color=auto -Slq | fzf --query="$1" --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --preview 'pacman -Si {1}')
	if test -z "$res"
		return
	else
		doas pacman --noconfirm -S $res
        echo "- cmd: doas pacman -S $res" >> ~/.local/share/fish/fish_history
        history merge
	end
end

function parm
	set -l res $(pacman --color=auto -Qq | fzf --query="$1" --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --preview 'pacman -Qi {1}')
	if test -z "$res"
		return
	else
		doas pacman -Rns $res
        echo "- cmd: doas pacman -Rns $res" >> ~/.local/share/fish/fish_history
        history merge
	end
end

function desk
	# relaunch DWl if the binary changes, otherwise bail
	# set -l csum ""
	# set -l new_csum (command sha1sum (command which dwl))
	# while true
	# 	if test "$csum" != "$new_csum" 
	# 		set -l csum $new_csum
			/usr/local/bin/dwl
			# /usr/local/bin/dwl > /dev/null 2>&1
		# else
		# 	exit 0
		# end
		# set -l new_csum (command sha1sum (command which dwl))
		# sleep 0.5
	# end
end

function su
	command	su --shell=/usr/bin/fish $argv
end

function wifi
    rfkill unblock wifi
    command iwctl station wlan0 connect CMCC-7JEE_5G
end

# function windows
    # if test "$argv" = "up"
        # virsh start win11 > /dev/null
        # nohup virt-viewer -a win11 > /dev/null 2>&1 & 
    # else if test "$argv" = "down"
    #     virsh shutdown win11 > /dev/null
    # else
    #     return 0
    # end
# end

#set -gx XDG_RUNTIME_DIR /tmp/xdg-runtime-$(id -u)
#mkdir -p $XDG_RUNTIME_DIR
#chmod 0700 $XDG_RUNTIME_DIR

# function gfw
# 	doas wget -O /usr/share/v2ray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
# 	doas wget -O /usr/share/v2ray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
# end
