#!/usr/bin/env fish
function of
	set -l target2open $(fd --hidden --follow . $HOME | fzf --height=60% --preview 'pv {}')
	if test -z $target2open
		return 0
	else if test -f $target2open
		switch $(path extension $target2open)
			case .pdf .org .el
				command emacs $target2open > /dev/null 2>&1 & disown
			case .png .jpg
				command swayimg $target2open > /dev/null 2>&1 & disown
			case .gif
				command chafa $target2open
			case '*'
				echo "- cmd: nvim $target2open" >> ~/.local/share/fish/fish_history
				history merge
				command nvim $target2open
		end
	else
		cd $target2open || exit
		ls -Al --color=always
	end
end
