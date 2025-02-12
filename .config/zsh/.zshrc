#!/usr/bin/env zsh
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export HISTFILE=$XDG_STATE_HOME/zsh/history
HISTORY_IGNORE="(of|pain|parm|desk)"

if [[ $(echo $HOST) != "friend" ]]; then
    HOST_PROMPT='@%m'
else
    HOST_PROMPT=''
fi

PS1='%F{green}%n'${HOST_PROMPT}' %f%~ %(?.%F{green}.%F{red})%f'

autoload -Uz compinit && compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
autoload -U select-word-style
select-word-style bash

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_NAME ]]
# then    
#     if [[ -o login ]]; then
#         LOGIN_OPTION='--login'
#     else
#         LOGIN_OPTION=''
#     fi    
#     SHELL=/bin/fish exec fish $LOGIN_OPTION    
# fi

# LC_ALL=C.UTF-8
# LANG=

precmd() {
    print -Pn "\e]133;A\e\\"
}

export XDG_RUNTIME_DIR=/tmp/xdg-runtime-$(id -u)
mkdir -p $XDG_RUNTIME_DIR
chmod 0700 $XDG_RUNTIME_DIR
doas chmod 777 /run/seatd.sock

function pain() {
    # res=$( pacman --color=auto -Slq | fzf --query=$1 --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --border --preview "bat <(pacman -Si {1})" )
	res=$(pacman --color=auto -Slq | fzf --query="$1" --exit-0 --sync --color=16 --height=60% --preview 'pacman -Si {1}')
    if [[ -z "$res" ]]; then
        return
    else
        doas pacman --noconfirm -S "$res"
    fi
}

function parm() {
    res=$(pacman --color=auto -Qq | fzf --query="$1" --exit-0 --sync --color=16 --height=60% --preview 'pacman -Qi {1}')
    if [[ -z "$res" ]]; then
        return
    else
        doas pacman -Runs $res
    fi
}

function desk() {
    dbus-run-session /usr/local/bin/dwl > /dev/null 2>&1
}

function of() {
    target2open=$(fd --hidden --follow . "$HOME" | fzf --height=60% --preview 'pv {}')

    if [[ -z $target2open ]]; then
        return 0
    elif [[ -f $target2open ]]; then
        case "${target2open##*.}" in
            pdf|org|el)
                exec setsid emacsclient -a '' -c "$target2open" > /dev/null 2>&1
                ;;
            # png|jpg)
            #     swayimg "$target2open" > /dev/null 2>&1 & disown
            #     ;;
            png|jpg|gif)
                chafa "$target2open"
                ;;
            *)
                echo "nvim $target2open" >> ~/.local/state/zsh/history
                history -n  # Update the history file
                nvim "$target2open"
                ;;
        esac
    else
        ls -al --color=always $target2open
        cd $target2open
        echo "cd $target2open" >> ~/.local/state/zsh/history
    fi
}

# function gfw(){
# doas wget -O /usr/share/v2ray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
# doas wget -O /usr/share/v2ray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
# }

# making ctrl+d will close shell if the command line is filled
# exit_zsh() { exit }
# zle -N exit_zsh
# bindkey '^D' exit_zsh

# # The following lines were added by compinstall
# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# zstyle ':completion:*' list-colors ''
# zstyle :compinstall filename '/home/chaos/.zshrc'

# # End of lines added by compinstall
# # Lines configured by zsh-newuser-install
HISTSIZE=100
SAVEHIST=1000
# bindkey -e
# setopt correctall
# # End of lines configured by zsh-newuser-install
export FZF_DEFAULT_OPTS_FILE=~/.config/.fzfrc
export FZF_DEFAULT_COMMAND="fd --hidden --ignore-file /home/chaos/.config/fd/ignore"
path+=('/home/chaos/garden/scripts')

# some plugin
# fpath=(/home/chaos/.config/zsh/zsh-completions/src $fpath)
source /home/chaos/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/chaos/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

