#!/bin/bash
# Author mouhamedfd http://github.com/mouhamedfd
# This script helps create busness card
# The size of each card should be 90mmx50mm
# Ten business card will be made and align on A4 paper size
source_file=$1
#--------------------------------------------------
#check for the input
#--------------------------------------------------
if [ -z $1 ] ;then
echo "usage : $0 source_file.pdf"
echo "The source ile is mandatory"
#--------------------------------------------------
#check for the presence of pdfjam and pdfunite
#---------------------------------------------------
elif ! [ -x "$(command -v pdfunite)" ]; then
echo "Error: pdfunite is not installed"

elif ! [ -x "$(command -v pdfjam)" ]; then
echo "Error: pdfjam is not installed"
#---------------------------------------------------
else
source_filename=${source_file%.*}
unit_source_file=$source_filename"_10_.pdf"
pdfunite $(for i in {1..10}; do echo -n $source_file" ";done) $unit_source_file
pdfjam --nup 2x5 --suffix "2x5" --no-landscape $unit_source_file
rm  $unit_source_file
fi
#---------------------------------------------------
