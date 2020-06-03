#!/bin/bash
# simple script to stream desktop over lan using vlc
# inpired by : https://superuser.com/questions/335885/stream-desktop-using-vlc
# mod by mouhamedfd
#
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] ;then
 echo this script use vlc media player to stream your desktop over lan
 echo $0 ip_adress port width height
else
ip_adress=$1
port=$2
width=$3
height=$4
cvlc screen:// --sout "#transcode{venc=x264{preset=ultrafast,tune=zerolatency,intra-refresh,lookahead=10,keyint=15},vcodec=h264,vb=4096,acodec=mpga,ab=256,scale=1,width=$3,height=$4‌​}:standard{access=http, mux=ts, dst=$1:$2} ,screen-left=-1600" --screen-fps=30 --sout-mux-caching=300 --clock-jitter=0 --
fi



