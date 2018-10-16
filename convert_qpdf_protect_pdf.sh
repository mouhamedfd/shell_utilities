#!/bin/bash
# Author mouhamedfd http://github.com/mouhamedfd
# Version 0.1 date 2017-February
# Licence open source
#------------------------------------------------------------------------
filename=$1
password=$2
quality=$3
key_length=256
# test  arguments
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ;then
	echo "Author mouhamedfd"
	echo " This script use qpdf to convert pdf as picture pdf and add password to it"
	echo "$0 <pdf_file> <password> <compression_level>"
elif [ -z $(which convert) ] ; then
	echo "ImageMagick convert is not available"
	echo "installation : apt-get install imagemagick | yum install imagemagick"
elif [ -z $(which qpdf) ] ; then
	echo "qpdf is not available"
	echo "installation : apt-get install qpdf | yum install qpdf"
else
# Traitement du fichier
	convert -density $3 $filename c_$filename
        qpdf --encrypt $password owner$password $key_length --use-aes=y -- c_$filename sc_$filename &&
	echo "operation done"
fi
exit 0
