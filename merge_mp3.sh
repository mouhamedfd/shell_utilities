#!/bin/bash
#--------------------------------------------------
# Merge mp3 files using ffmpeg
# by mouhamedfd
#--------------------------------------------------
concat="concat:"
for i in *.mp3
do
concat+=$i"|"
done
concat=${concat%|}  #remove the trailing |
echo "running command : ffmpeg -i $concat -acodec copy out.mp3"
ffmpeg -i $concat -acodec copy merge.mp3
