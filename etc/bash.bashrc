#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

# [ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
# then
# 	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
# 	exec fish $LOGIN_OPTION
# fi

export SWAYSOCK=/run/user/$(id -u)/dwl-ipc.$(id -u).$(pgrep -x dwl).sock    

export XDG_RUNTIME_DIR="/tmp/xdg-runtime-$(id -u)"
mkdir -p $XDG_RUNTIME_DIR
chmod 0700 $XDG_RUNTIME_DIR

shopt -s autocd
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
export LESS='-R --use-color -Dd+r$Du+b$'
