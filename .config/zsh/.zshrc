#!/usr/bin/env zsh
export ZDOTDIR=$HOME/.config/zsh
export FZF_DEFAULT_OPTS_FILE=$HOME/.config/.fzfrc
# export NO_AT_BRIDGE=1
alias ros2box="distrobox enter ubuntu-24-04"

# autoload -Uz zsh/terminfo
# if [[ -n "$terminfo[kcuu1]" ]]; then
#   bindkey "$terminfo[kcuu1]" up-line-or-history    # ↑
#   bindkey "$terminfo[kcud1]" down-line-or-history  # ↓
# fi
# bindkey "^W" backward-kill-word  # 添加到 ~/.zshrc

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_NAME ]]
# then    
#     if [[ -o login ]]; then
#         LOGIN_OPTION='--login'
#     else
#         LOGIN_OPTION=''
#     fi    
#     SHELL=/bin/fish exec fish $LOGIN_OPTION    
# fi

# precmd() {
#     print -Pn "\e]133;A\e\\"
#     if ! builtin zle; then
#         print -n "\e]133;D\e\\"
#     fi
# }
# preexec() {
#     print -n "\e]133;C\e\\"
# }

function wifi() {
    iwctl --username zhangchy268 --password Bpppwuc%13 station wlan0 connect SYSU-SECURE
    # doas wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/SYSU.conf
    # doas systemctl start dhcpcd@wlan0
}

function trash() {
    local file="$(readlink -f $1)"
    local trash_bin="$HOME/just_in_case"

    if [[ ! -e "$file" ]]; then
        return 1
    fi
    local timestamp=$(date +%y%m%d)
    local trash_file="$trash_bin/$(basename "$file")_$timestamp"
    mv "$file" "$trash_file"
}

function recycle() {
    local trash_bin="$HOME/just_in_case"
    find "$trash_bin" -type f -mtime +30 -exec rm -f {} \;
}

function pain() {
    # res=$( pacman --color=auto -Slq | fzf --query=$1 --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --border --preview "bat <(pacman -Si {1})" )
    pacman -Slq | fzf --algo=v1 --exit-0 --sync --height=60% --preview 'pacman -Si {1}' | xargs -ro doas pacman --noconfirm -S
	# res=$(pacman --color=auto -Slq | fzf --query="$1" --exit-0 --sync --height=60% --preview 'pacman -Si {1}')
	#    if [[ -z "$res" ]]; then
	#        return
	#    else
	#        doas pacman --noconfirm -S "$res"
	#    fi
}

function parm() {
    pacman -Qq | fzf --algo=v1 --exit-0 --sync --height=60% --preview 'pacman -Qi {1}' | xargs -ro doas pacman -Rns
    # res=$(pacman --color=auto -Qq | fzf --query="$1" --exit-0 --sync --height=60% --preview 'pacman -Qi {1}')
    # if [[ -z "$res" ]]; then
    #     return
    # else
    #     doas pacman -Runs $res
    # fi
}

function desk() {
    # dbus-run-session /usr/local/bin/dwl > /dev/null 2>&1
    /usr/local/bin/dwl <&-
}

function of() {
	# if "$1"; then
	# 	target2open=$(fd -c never --hidden --follow . ~ | fzf -q "$1" --algo=v2 --sync --height=60% --preview '/home/chaos/garden/scripts/pv {}')
	# else
		target2open=$(fd -c never --hidden --follow . ~ | fzf --algo=v2 --sync --height=60% --preview '/home/chaos/garden/scripts/pv {}')
	# fi

    if [[ -z $target2open ]]; then
        return 0
    elif [[ -f $target2open ]]; then
        case "${target2open##*.}" in
            org|el)
                emacsclient -a '' -c "$target2open" > /dev/null 2>&1 & disown
                ;;
            # png|jpg)
            #     swayimg "$target2open" > /dev/null 2>&1 & disown
            #     ;;
            png|jpg|gif)
                chafa "$target2open"
                ;;
            pdf)
                zathura "$target2open" > /dev/null 2>&1 & disown
                ;;
            *)
                print -s "nvim $target2open"
                # history -n  # Update the history file
                nvim "$target2open"
                ;;
        esac
    else
        ls -al --color=always $target2open
        cd $target2open
        print -s "cd $target2open"
    fi
}

function jy() {
	jyfile="$1"
	printf "output path: "
	jypath="$read"
	if [ ! -d "$jypath" ]; then
        mkdir -p "$jypath"
    fi
	tar -xzf "$jyfile" -C "$jypath"
}

function dsup() {
    llama-server --model ./DeepSeek-R1-Distill-Qwen-14B-GGUF/DeepSeek-R1-Distill-Qwen-14B-Q4_K_M.gguf --port 10000 --ctx-size 1024 --n-gpu-layers 40
}

function multipy() {
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init - zsh)"
}

# function gfw(){
# doas wget -O /usr/share/v2ray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
# doas wget -O /usr/share/v2ray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
# }

# # The following lines were added by compinstall
# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# zstyle ':completion:*' list-colors ''
# zstyle :compinstall filename '/home/chaos/.zshrc'

# # End of lines added by compinstall
# # Lines configured by zsh-newuser-install
# # End of lines configured by zsh-newuser-install
# path+=('/home/chaos/garden/scripts')
