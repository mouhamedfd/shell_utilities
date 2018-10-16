#!/bin/bash 
#Author mouhamedfd
#This script is useful when you have a lot of picttures inside pdf file
#[use with care in draft mode]
input_file="$1"
resolution="$2"
output_file=out_"$input_file"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/screen -dColorImageResolution=$resolution -dGrayImageResolution=$resolution -dColorImageDownsampleType=/Bicubic -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
