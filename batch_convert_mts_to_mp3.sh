#! /bin/bash
#----------------------------------------------------------------------
# Using ffmpeg for batch converting MTS file to mp3
# by mouhamedfd
# go to https://www.ffmpeg.org/ for more info 
#----------------------------------------------------------------------
bit_rate= 80k #80kbps
for i in *.MTS 
do
echo "Processing file : "$i "----> "${i%.*}.mp3
ffmpeg -i $i -vn \
       -acodec libmp3lame -ac 2 -ab $bit_rate -ar 48000 \
        ${i%.*}.mp3
done
