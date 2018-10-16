#!/bin/bash
# Author mouhamedfd http://github.com/mouhamedfd
# Version 0.1 date 2017-February
# Licence open source
#------------------------------------------------------------------------
filename=$1
password=$2
quality=$3
# test  arguments
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ;then
	echo "Author mouhamedfd"
	echo " This script use pdftk to convert pdf as picture pdf and add password to it"
	echo "$0 <pdf_file> <password> <compression_level>"
elif [ -z $(which convert) ] ; then
	echo "ImageMagick convert is not available"
	echo "installation : apt-get install imagemagick | yum install imagemagick"
elif [ -z $(which pdftk) ] ; then
	echo "pdftk is not available"
	echo "installation : apt-get install pdftk | yum install pdftk"
else
# Traitement du fichier
	convert -density $3 $filename c_$filename
	pdftk c_$filename output  lc_$filename user_pw $2 owner_pw owner$password &&
	echo "operation done"
fi
exit 0
