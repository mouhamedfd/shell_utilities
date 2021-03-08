#!/usr/bin/python3
# script to generate pdf using wkhtmltopdf and password protect the pdf using qpdf
# Author mouhamedfd http://github.com/mouhamedfd
# Version 0.2 date 2021-March
# to be use with pdf generator
# Example
# https://github.com/KnpLabs/snappy or https://github.com/barryvdh/laravel-snappy
# $snappy = new Pdf();
# $snappy->setBinary('/usr/local/bin/wkhtmltopdfprotect.py password');
import os
import sys
import shutil
from subprocess import PIPE, CalledProcessError, check_call, Popen

keep_backup_file=False
wkhtmltopdf_path="/usr/local/bin/wkhtmltopdf"
qpdf_path="/usr/bin/qpdf"
#-------------------------------------------------------
password=sys.argv[1]
arguments=sys.argv[2:] #get arguments for wkhtml
output_file=arguments[len(arguments)-1]
base_path=os.path.splitext(output_file)[0]
backup_output_file=base_path+".bak.pdf"
#-------------------------------------------------------
command=arguments[:] #copy without reference
command.insert(0,wkhtmltopdf_path)
#-------------------------------------------------------


try:
    out_wkhtml = Popen(command, stdout=PIPE)
    stdout_wkhtml, stderr_wkhtml = out_wkhtml.communicate()
    exit_code_wkhtml=out_wkhtml.returncode
except CalledProcessError as e:
    print(e)
    sys.exit(1)


#-------------------------------------------------------
#copy the generated file
shutil.copy2(output_file, backup_output_file)
#-------------------------------------------------------
#password protect the file
try:
    out_qpdf = Popen([qpdf_path,'--encrypt' ,password ,password ,'256', '--use-aes=y','--',backup_output_file,output_file], stdout=PIPE)
    stdout_qpdf, stderr_qpdf = out_qpdf.communicate()
    exit_code_qpdf=out_qpdf.returncode
except CalledProcessError as e:
    print(e)
    sys.exit(1)
#-------------------------------------------------------
#optional
#to delete the backup file
if(not keep_backup_file):
    os.remove(backup_output_file)
#-------------------------------------------------------
