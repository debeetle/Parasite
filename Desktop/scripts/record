#!/bin/env zsh

#global settings
fps="24"
codec="h264 vaapi"
threads="4"

#actual ffmpeg command
ffmpeg \
	-threads $threads \
	-f alsa \ 
	-thread_queue_size 1024 \
	-ac 1 \
	-i hw:$1 \
	\
	-f kmsgrab \
	-framerate $fps \
	-thread_queue_size 1024 \
	-i - \
	\
	-vf 'hwmap=derive_device=vappi,scale_vaapi=w=1920:h=1000:format=nv12' \
	-r $fps \
	-c:v $codec -g $((fps * 2)) \
	\
	-c:a aac \
	\
	$2

#the other script found on forums
ffmpeg -device /dev/dri/card0 \
	-f kmsgrab -framerate 60 \
	-i - \
	-vaapi_device /dev/dri/renderD128 \
	-vf 'hwmap=derive_device=vaapi,crop=1434:650:974:774,scale_vaapi=w=1435:h=650:format=nv12' \
	-c:v hevc_vaapi \
	-qp 18 -y output-file.mkv
