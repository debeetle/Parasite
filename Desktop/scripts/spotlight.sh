#!/usr/bin/dash
# set -eu -o pipefail
# app=$(
	# pymenu $(printf "alacritty\naudacity\nblender\nchromium\nemacs\nepiphany\nfirefox\nfoot\nfreecad\ngimp\ngodot\nhavoc\nhpc_server\nideamaker\ninkscape\nipe\nkitty\noctave\nokular\nopenscad\nrustdesk\nrviz\nsonic\nsteam\nqutebrowser\nvirtualbox\nwebots\nzathura")
# 	pymenu "alacritty" "audacity" "blender" "chromium" "emacs" "epiphany" "firefox" "foot" "freecad" "gimp" "godot" "havoc" "hpc_server" "ideamaker" "inkscape" "ipe" "kitty" "octave" "okular" "openscad" "rustdesk" "rviz" "sonic" "steam" "qutebrowser" "virtualbox" "webots" "zathura"
# )

# app=$(printf "%s\n" \
# 	alacritty audacity blender chromium emacs epiphany firefox foot freecad gimp godot havoc ideamaker inkscape ipe kitty matlab octave okular openscad rustdesk rviz \
# 	servo sonic steam qutebrowser virtualbox webots zathura \
# | fzf --style=minimal --info=hidden --color=gutter:#eeeeee)

app=$(printf "%s\n" \
	alacritty audacity blender chromium emacs epiphany firefox foot freecad gimp godot havoc hpc_server ideamaker inkscape ipe kitty octave okular openscad rustdesk rviz \
	sonic steam qutebrowser virtualbox webots zathura |
	fzy -p "")

# exec setsid dash -c "${app}" > /dev/null 2>&1
# setsid dash -c "${app} &"

if [ -z "${app}" ]; then
	exit 0
fi

case "${app}" in
emacs)
	# setsid dash -c "emacsclient -a '' -c &"
	setsid dash -c "emacsclient -r &"
	;;
epiphany)
	setsid dash -c "GDK_BACKEND=x11 epiphany &" # x11 or empty content
	;;
	# firefox)
	#        exec setsid dash -c "firefox <&-"
	#        ;;
foot)
	setsid dash -c "footclient --log-level none &"
	;;
freecad)
	setsid dash -c "QT_QPA_PLATFORM=xcb freecad &" # x11 or black content
	;;
hpc_server)
	setsid dash -c "xfreerdp3 +f +async-update +async-channels +rfx /frame-ack:0 /cert:tofu /log-level:off /gfx:progressive /gfx:AVC444 /u:chaos /p:bp /v:172.25.4.47 &"
	;;
ideamaker)
	setsid dash -c "distrobox enter ubuntu2404 -- sh -c 'QT_QPA_PLATFORM=xcb ideamaker' &"
	;;
# matlab)
# 	export MAT="/home/chaos/matlab25a"
# 	export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}\
# $MAT/bin/glnxa64:\
# $MAT/sys/os/glnxa64:\
# $MAT/extern/bin/glnxa64:\
# $MAT/sys/opengl/lib/glnxa64"
#
# 	setsid dash -c "env	AWT_TOOLKIT=MToolkit QT_QPA_PLATFORM=xcb matlab -desktop & disown"
# 	;;
octave)
	setsid dash -c "octave --gui &"
	;;
openscad)
	setsid dash -c "QT_QPA_PLATFORM=xcb openscad &"
	;;
rviz)
	setsid dash -c "distrobox enter ubuntu2404 -- bash -c 'source /opt/ros/jazzy/setup.bash && QT_QPA_PLATFORM=xcb ros2 run rviz2 rviz2' &"
	# setsid dash -c "distrobox enter ubuntu-24-04 -- bash -c 'source /opt/ros/jazzy/setup.bash && ros2 run rviz2 rviz2' &"
	;;
sonic)
	setsid dash -c "sonic-visualiser &"
	;;
*)
	# if which "$app" > /dev/null; then
	setsid dash -c "${app} &"
	# exec setsid dash -c "${app} <&-"
	# else
	# firefox --new-tab --search "$app"
	# /usr/bin/qutebrowser --target auto "$app" > /dev/null 2>&1 &
	# fi
	;;
esac
