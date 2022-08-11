#!/bin/bash
#script to export postgres database to a cloud service using rclone ---> https://rclone.org/
#This script can be use for automated database backup with cron ---> https://man7.org/linux/man-pages/man5/crontab.5.html
#To send notification to a slack channel ---> https://api.slack.com/tutorials/slack-apps-hello-world
#pg_dump doc ---> https://www.postgresql.org/docs/current/app-pgdump.html 
# by mouhamedfd
#---------------------------------------------------------------------------------
#database infos [the same in .pgpass file]
#put the DB credentials in ~/.pgpass file as :
#-----------> host:port:dbname:dbuser:dbpassword <--------------------------------
# Set the permissions to 0600 ---> sudo chmod 0600 ~/.pgpass
#---------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
dbname=
dbuser=
dbhost=
#Full path of this script
spath=
month_folder=Backup-$(date +"%Y-%m")
#create the dumps folder if it doesnt exist
if [ ! -e $spath/dumps ]
 then
 mkdir -p $spath/dumps
fi
#create the monthly dumps folder if it doesnt exist
if [ ! -e $spath/dumps\/$month_folder ]
 then
 mkdir -p $spath/dumps\/$month_folder
fi
#Name of the remote in rclone
rclone_remote_name=
#The filename
filename=dumps\/$month_folder\/dump-$(date +'%Y_%m_%dT%HH_%MM_%SS')-$dbname-database.sql
#For use to notify a slack channel about the operation
slack_webhook_url=
#Dumping database using the configuration in ~/.pgpass that contains user and password
pg_dump -U $dbuser -h $dbhost -d $dbname -f $spath/$filename \
--exclude-table-data 'public.*a_specific_tablename' \
2>> $spath/error.log
#sending the dumps to the cloud, in pgdump folder
rclone copy  $spath/dumps $rclone_remote_name:pgdump 2>> $spath/rclone-error.log
#Get some informations
info=$(du -sh $spath)
#nb_files=$(ls -1 "$spath/dumps"|wc -l)
nb_files=$(tree "$spath/dumps"|tail -n1)
info="$info $nb_files"
#Notify Slack channel
curl -X POST -H 'Content-type: application/json' --data-binary '{"text":"New DB Backup '"$info"' "}' $slack_webhook_url

#---------------------------------------------------------------------------------
