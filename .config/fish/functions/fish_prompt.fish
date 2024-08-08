function fish_prompt --description 'Write out the prompt'
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -l normal (set_color normal)
	set -q fish_color_status
	or set -g fish_color_status red

	#Color the prompt differently when we're root
	set -l color_cwd $fish_color_cwd
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		end
	end

	#Write pipestatus
	#If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
	set -l bold_flag --bold
	set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
	if test $__fish_prompt_status_generation = $status_generation
		set bold_flag
	end
	set __fish_prompt_status_generation $status_generation
	set -l status_color (set_color $fish_color_status)
	set -l statusb_color (set_color $bold_flag $fish_color_status)
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

	function prompt_login_custom --description 'little changes to the /etc/fish/functions/prompt_login.fish'
		# Prepend the chroot environment if present
		if set -q __fish_machine[1]
			echo -n -s (set_color yellow) "$__fish_machine" (set_color normal) ' '
		end

		# If we're running via SSH, change the host color.
		set -l color_host $fish_color_host
		if set -q SSH_TTY; and set -q fish_color_host_remote
			set color_host $fish_color_host_remote
		end

		if set -q SSH_TTY
			set -g fish_color_host brred
			echo -n -s (set_color $color_host) "[" (prompt_hostname) "]" (set_color $fish_color_user) "$USER" (set_color normal)
		else
			echo -n -s (set_color $fish_color_user) "$USER" (set_color normal)
		end
	end

	echo -n -s (prompt_login_custom)' ' (set_color $color_cwd) (prompt_pwd) $normal " "$prompt_status " "
	#echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "

	#set -l last_status $status
	#
	#if not set -q __fish_git_prompt_show_informative_status
	#  set -g __fish_git_prompt_show_informative_status 1
	#end
	#if not set -q __fish_git_prompt_color_branch
	#  set -g __fish_git_prompt_color_branch brmagenta
	#end
	#if not set -q __fish_git_prompt_showupstream
	#  set -g __fish_git_prompt_showupstream "informative"
	#end
	#if not set -q __fish_git_prompt_showdirtystate
	#  set -g __fish_git_prompt_showdirtystate "yes"
	#end
	#if not set -q __fish_git_prompt_color_stagedstate
	#  set -g __fish_git_prompt_color_stagedstate yellow
	#end
	#if not set -q __fish_git_prompt_color_invalidstate
	#  set -g __fish_git_prompt_color_invalidstate red
	#end
	#if not set -q __fish_git_prompt_color_cleanstate
	#  set -g __fish_git_prompt_color_cleanstate brgreen
	#end
	#
	#printf '%s%s %s%s%s%s ' (set_color $fish_color_host) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (__fish_git_prompt)
	#
	#if not test $last_status -eq 0
	#  set_color $fish_color_error
	#end
	#echo -n '$ '
	#set_color normal
end
