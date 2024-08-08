#!/usr/bin/env fish
function psf
	set -l tmpfile (mktemp)
	if test $argv
		# ps ax -o pid,time,command | fzf --color=light -q $argv --height=50% | awk '{print $1}' | xargs kill
		ps ax -o pid,time,command | fzy -l 40 -q $argv -p '/' | awk '{print $1}' > $tmpfile
	else
		# ps ax -o pid,time,command | fzf --color=light --height=50% | awk '{print $1}' | xargs kill
		ps ax -o pid,time,command | fzy -l 40 -p '/' | awk '{print $1}' > $tmpfile
	end

	if test -z $(cat $tmpfile)
		return 0
	else
		doas kill $(cat $tmpfile)
	end

	rm $tmpfile
end
