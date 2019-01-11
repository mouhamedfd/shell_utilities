
#!/bin/bash
#
# convert an mp3 file to wav format and split it to chuncks using the specified duration
# by mouhamedfd 
#--------------------------------------------------------------------------------------
segment_duration=45 #in second
#--------------------------------------------------------------------------------------
# -ar Set the audio sampling frequency.
# -ac Set the number of audio channels.
#--------------------------------------------------------------------------------------
audiofile=$1
audio_wo_ext=${audiofile%.*}

if [ -f $audiofile -a ! -z "$audiofile" ] ; then
 echo converting to wav
 ffmpeg -i $audiofile -ar 16000 -ac 1 $audio_wo_ext.wav
 echo conversion to $audio_wo_ext.wav done
else
 echo Give mp3 file to convert and split please
fi

if [ -f $audio_wo_ext.wav -a ! -z "$audiofile" ] ; then
 echo splitting the file ...
 ffmpeg -i  $audio_wo_ext.wav -f segment -segment_time $segment_duration -c copy out%09d.wav
 echo splitting done, check files  
fi
