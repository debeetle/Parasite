#!/usr/bin/env dash
killall swaybg

light() {
	/usr/bin/swaybg -m fill -i "/opt/fasthome/Parasite/Desktop/wallpaper/light/$(shuf -n 1 /opt/fasthome/Parasite/Desktop/wallpaper/light/piclist)" &
	sed -i '2s/true/false/' ~/.config/gtk-3.0/settings.ini
	sed -i '19s/dracula/studio98/' /opt/fasthome/Parasite/etc/xdg/nvim/sysinit.vim
	sed -i '5,7s/dracula/catppuccin/' ~/.config/qutebrowser/config.py
	sed -i '78s/dark/light/' /opt/fasthome/garden/scripts/pv.sh
	ln -fs /opt/fasthome/Parasite/.config/fzf_light ~/.config/.fzfrc
	# sed -i '3s/dracula/adwaita/' ~/.config/emacs/init.el
	pkill -u "$USER" --signal=SIGUSR1 ^foot$
	emacsclient -e "(my/apply-theme 'adwaita)"
	dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" >/dev/null 2>&1
	# sed -i '5,7s/dracula/catppuccin/;8s/dark/light/' ~/.config/qutebrowser/config.py

	# sed -i '22s/default-dark/rose-pine/' ~/.config/fcitx5/conf/classicui.conf
	# gsettings set org.gnome.desktop.interface color-scheme prefer-light
	# sed -i '14,45s/^#//;49,87s/^/#/' ~/.config/zathura/zathurarc
}

dark() {
	/usr/bin/swaybg -m fill -i "/opt/fasthome/Parasite/Desktop/wallpaper/dark/$(shuf -n 1 /opt/fasthome/Parasite/Desktop/wallpaper/dark/piclist)" &
	sed -i '2s/false/true/' ~/.config/gtk-3.0/settings.ini
	sed -i '19s/studio98/dracula/' /opt/fasthome/Parasite/etc/xdg/nvim/sysinit.vim
	sed -i '5,7s/catppuccin/dracula/' ~/.config/qutebrowser/config.py
	sed -i '78s/light/dark/' /opt/fasthome/garden/scripts/pv.sh
	ln -fs /opt/fasthome/Parasite/.config/fzf_dark ~/.config/.fzfrc
	# sed -i '3s/adwaita/dracula/' ~/.config/emacs/init.el
	pkill -u "$USER" --signal=SIGUSR2 ^foot$
	emacsclient -e "(my/apply-theme 'dracula)"
	dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" >/dev/null 2>&1
	# sed -i '5,7s/catppuccin/dracula/;8s/light/dark/' ~/.config/qutebrowser/config.py

	# sed -i '22s/rose-pine/default-dark/' ~/.config/fcitx5/conf/classicui.conf
	# gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	# sed -i '14,45s/^/#/;49,87s/^#//' ~/.config/zathura/zathurarc
}

hour=$(date +%H)
if [ "$hour" -gt 17 ] || [ "$hour" -lt 05 ]; then
	dark
else
	light
fi
