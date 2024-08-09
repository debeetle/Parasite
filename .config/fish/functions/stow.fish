#!/usr/bin/env fish
function stow
	read -l -P 'Commit what: ' message
	if test -z $message
		return
	end

    set -l backup_path /home/trunk/Parasite

    # copy some files instead of symbol links
    doas cp -u /boot/loader/loader.conf $backup_path/boot/loader/
    doas cp -u /boot/loader/entries/* $backup_path/boot/loader/entries/
    doas cp -u /etc/doas.conf $backup_path/etc/; doas chown trunk:trunk $backup_path/etc/doas.conf; doas chmod 660 $backup_path/etc/doas.conf

	cd $backup_path
	git add .
	git commit -m $message
	read -n 1 -l -P 'Push, all right? [Y/n]' confirm
	switch $confirm
		case '' Y y
			git push
		case '*'
			printf 'Till we meet again'
	end
	cd ~
end
