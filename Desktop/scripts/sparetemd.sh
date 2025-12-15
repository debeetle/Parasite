#!/usr/bin/bash
# pacman_log=$(doas pacman -Syyu --noconfirm)

# 提取升级包的信息
# awk way
# package_list=$(echo $(pacman_log) | awk '/Packages/{for(i=3;i<=NF;i++) printf "%s ", $i; print ""}' )

# sed way
package_list=$(doas pacman -Syyu --noconfirm | sed -n '/Packages/s/.*Packages (.*) //p')

kernel_update=$(echo ${package_list} | grep -q -e "linux-clear-x64")
wlr_update=$(echo ${package_list} | grep -q -e "linux-clear-x64")

if [[ $kernel_update ]]; then
	footclient -T alert -W 40x15 zsh -c '
    read -s -p "New kernel detected in upgration, you may want to reboot"'
elif [[ $wlr_update ]]; then
	footclient -T alert -W 40x15 zsh -c '
    read -s -p "wlroots updated, carefully exit dwl till you check code online"'
fi
