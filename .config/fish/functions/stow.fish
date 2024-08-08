#!/usr/bin/env fish
function stow
	read -l -P 'Commit what: ' message
	if test -z $message
		return 0
	end

    # copy some files instead of symbol links
    doas cp -u /boot/loader/loader.conf /home/trunk/Parasite/boot/loader/
    doas cp -u /boot/loader/entries/* /home/trunk/Parasite/boot/loader/entries/

	cd /home/trunk/Parasite
	git add .
	git commit -m $message
	read -n 1 -l -P 'All right, Push? [Y/n]' confirm
	switch $confirm
		case '' Y y
			git push
		case '*'
			printf 'Till we meet again'
	end
	cd
end
