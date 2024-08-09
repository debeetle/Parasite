#!/usr/bin/env fish
function stow
	read -l -P 'Commit what: ' message
	if test -z $message
		return
	end

    # copy some files instead of symbol links
    doas cp -u /boot/loader/loader.conf /home/trunk/Parasite/boot/loader/
    doas cp -u /boot/loader/entries/* /home/trunk/Parasite/boot/loader/entries/
    doas cp -u /etc/doas.conf /home/trunk/Parasite/etc/; doas chown trunk:trunk /home/trunk/Parasite/etc/doas.conf; doas chmod 660 /home/trunk/Parasite/etc/doas.conf

	cd /home/trunk/Parasite
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
