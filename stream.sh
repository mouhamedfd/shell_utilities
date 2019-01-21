#!/bin/bash
# simple script to stream desktop over lan using vlc
# inpired by : https://superuser.com/questions/335885/stream-desktop-using-vlc
# mod by mouhamedfd
#
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ;then
 echo this script use vlc media player to stream your desktop over lan
 echo $0 ip_adress port width height
else
ip_adress=$1
port=$2
width=$3
height=$4
cvlc screen:// :screen-fps=30 :screen-caching=100 --sout '#transcode{vcodec=h264,vb=4096,acodec=mpga,ab=256,scale=1,width=1280,height=800‌​}:standard{access=http, mux=ts, dst=192.168.2.139:8085}'
fi



