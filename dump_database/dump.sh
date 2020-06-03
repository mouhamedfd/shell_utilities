#!/bin/bash
#script to export database to a cloud service using rclone ---> https://rclone.org/
#This script can be use for automated database backup with cron ---> https://man7.org/linux/man-pages/man5/crontab.5.html
#To send notification to a slack channel ---> https://api.slack.com/tutorials/slack-apps-hello-world
# by mouhamedfd
#---------------------------------------------------------------------------------
#database name
dbname=
#Full path of this script
spath=
#Name of the remote in rclone
rclone_remote_name=
#The filename
filename=dumps\/dump-$(date +'%Y-%m-%dT%H:%M:%S')-$dbname-database.sql
#For use to notify a slack channel about the operation
slack_webhook_url=
#Dumping database using the configuration file my.cnf that contains user and password
mysqldump --defaults-extra-file=$spath/my.cnf $dbname > $spath/$filename 2>> $spath/error.log
#sending the dumps to the cloud
rclone copy  $spath/dumps $rclone_remote_name:mysqldump 2>> $spath/rclone-error.log
#Get some informations
info=$(du -sh $spath)
nb_files=$(ls -l "$spath/dumps"|wc -l)
info="$info $nb_files files"
#Notify Slack channel
curl -X POST -H 'Content-type: application/json' --data-binary '{"text":"New DB Backup '"$info"' "}' $slack_webhook_url

#---------------------------------------------------------------------------------