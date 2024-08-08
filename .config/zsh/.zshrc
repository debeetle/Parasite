#!/usr/bin/env zsh
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_STATE_HOME/zsh/history"

autoload -Uz compinit
compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_NAME ]]
# then    
#     if [[ -o login ]]; then
#         LOGIN_OPTION='--login'
#     else
#         LOGIN_OPTION=''
#     fi    
#     SHELL=/bin/fish exec fish $LOGIN_OPTION    
# fi

LC_ALL=C
LANG=C

export XDG_RUNTIME_DIR=/tmp/xdg-runtime-$(id -u)
mkdir -p $XDG_RUNTIME_DIR
chmod 0700 $XDG_RUNTIME_DIR

function pain() {
res=$( pacman --color=auto -Slq | fzf --query=$1 --exit-0 --sync --color=16 --algo=v1 --multi --height=60% --border --preview "bat <(pacman -Si {1})" )
doas pacman --noconfirm -S "$res"
}

function update(){
	doas pacman -Syyu --noconfirm
	doas pacman -Rdd qt5-webengine qt5-webchannel qt5-location qt5-declarative qt6-translations
}

function printscreen(){
	scrot ~/%m-%d-%Y-%H%M%S.png -q 100 --select --line mode=edge
}

# function gfw() {
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
# zstyle :compinstall filename '/home/trunk/.zshrc'

# # End of lines added by compinstall
# # Lines configured by zsh-newuser-install
# HISTSIZE=100
# SAVEHIST=1000
# bindkey -e
# setopt correctall
# # End of lines configured by zsh-newuser-install

export FZF_DEFAULT_COMMAND="fd --hidden --ignore-file /home/trunk/.config/fd/ignore"

# some plugin
fpath=(/home/trunk/.config/zsh/zsh-completions/src $fpath)
source /home/trunk/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/trunk/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
