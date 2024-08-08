#!/usr/bin/env fish
function paintest
	# set package $()
	set arrange $( paru --color=auto -Sl | sed -e 's: :/:; s/ unknown-version//' | fzf --color=light --algo=v1 --multi --height=60% -q "$1" --preview "paru --color=auto -Siq --topdown {1} | grep --color=auto -v '^ '")
	if test -z $arrange
		pkill paru
		return 0
	else
		paru --noconfirm -S $arrange
	end
end

# paru -Slq | fzf --multi --preview 'cat <(paru -Si {1}) <(paru -Fl {1} | awk "{print \$2}")' | xargs -ro doas pacman -S
# paru --color=auto -Sl | sed -e 's: :/:; s/ unknown-version//' | fzf --algo=v1 --multi --height=60% -q "$1" --preview "paru --color=auto -Siq --topdown {1} | grep --color=auto -v '^ '"| xargs -ro paru --noconfirm -S
