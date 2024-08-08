#!/usr/bin/env fish
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x GOPATH $XDG_DATA_HOME/go
set -x KERAS_HOME $XDG_STATE_HOME/keras

function sun
	set -l hour (date +%H)
	if test $hour -gt 16 -o $hour -lt 05
		echo "y" | fish_config theme save Dracula
		#set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --no-mouse --info=inline --reverse --ansi --multi --no-hscroll --no-scrollbar --preview-window=60%"
	else
		echo "y" | fish_config theme save latte
		#set -Ux FZF_DEFAULT_OPTS "--color=bg+:#ccd0da,spinner:#dc8a78,hl:#d20f39 --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#fe640b --no-mouse --info=inline --reverse --ansi --multi --no-hscroll --no-scrollbar --preview-window=60%"
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
	# abbr -a huan "wget -O - -q reddit.com/r/wallpaper.json | jq '.data.children[] |.data.url' | tail -6 | xargs feh --no-fehbg --bg-fill --random"
	# abbr --add nuc 'a602@10.168.38.7'
end

if status is-login
    sun
	exec bash -c "test -e /etc/profile && source /etc/profile;\
	exec  fish"
    cp ~/.config/fish/key-value /tmp/
end

function pain 
	set -l res $(pacman --color=auto -Slq | fzf --query="$1" --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --preview 'pacman -Si {1}')
	if test -z "$res"
		return 0
	else
		doas pacman --noconfirm -S $res
        echo "- cmd: doas pacman -S $res" >> ~/.local/share/fish/fish_history
        history merge
	end
end

function parm
	set -l res $(pacman --color=auto -Qq | fzf --query="$1" --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --preview 'pacman -Qi {1}')
	if test -z "$res"
		return 0
	else
		doas pacman -Rns $res
        echo "- cmd: doas pacman -Rns $res" >> ~/.local/share/fish/fish_history
        history merge
	end
end

function desk
	# relaunch DWl if the binary changes, otherwise bail
	#set -l csum ""
	#set -l new_csum (command sha1sum (command which dwl))
	#while true
	#	if test "$csum" != "$new_csum" 
	#		set -l csum $new_csum
			dbus-run-session /usr/local/bin/dwl >/dev/null 2>&1
	#	else
	#		exit 0
	#	end
	#	set -l new_csum (command sha1sum (command which dwl))
	#	sleep 0.5
	#end
end

function su
	command	su --shell=/usr/bin/fish $argv
end

#set -gx XDG_RUNTIME_DIR /tmp/xdg-runtime-$(id -u)
#mkdir -p $XDG_RUNTIME_DIR
#chmod 0700 $XDG_RUNTIME_DIR

# function gfw
# 	doas wget -O /usr/share/v2ray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
# 	doas wget -O /usr/share/v2ray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
# end
