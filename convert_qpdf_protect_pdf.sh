#!/bin/bash
# Author mouhamedfd http://github.com/mouhamedfd
# Version 0.1 date 2017-February
# Licence open source
#------------------------------------------------------------------------
set -o posix
file=$1
full_directory="$(realpath $1)"
filename="$(basename $1)"
directory=${full_directory%${filename}} #two variable substitution
password=$2
density=$3
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
# Handling the file
	convert -density $density $directory/$filename $directory/c_$filename
        qpdf --encrypt $password owner$password $key_length --use-aes=y -- $directory/c_$filename $directory/sc_$filename &&
	echo "operation done"
fi
exit 0
#------------------------------------------------------------------------------------------
#Troubleshooting
# if you have som problems with convert, here is a temporary fix
# edit the file /etc/ImageMagick-6/policy.xml
# replace  <policy domain="coder" rights="none" pattern="PDF" />
# by       <policy domain="coder" rights="read|write" pattern="PDF" />
#------------------------------------------------------------------------------------------
