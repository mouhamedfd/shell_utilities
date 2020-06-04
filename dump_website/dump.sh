#!/bin/bash
#script to backup Website or App to a cloud service using rclone ---> https://rclone.org/
#This script can be use for automated database backup with cron ---> https://man7.org/linux/man-pages/man5/crontab.5.html
#To send notification to a slack channel ---> https://api.slack.com/tutorials/slack-apps-hello-world
# by mouhamedfd
#---------------------------------------------------------------------------------
#database name
dumpname=
#Full path of this script
spath=
#create the dumps folder if it doesnt exist
if [ ! -e $spath/dumps ]
 then
 mkdir -p $spath/dumps
fi
#website or app path to be compressed
webpath=
#Name of the remote in rclone
rclone_remote_name=
#The filename
filename=dumps\/dump-$(date +'%Y-%m-%dT%H:%M:%S')-$dumpname-app.tar.gz
#For use to notify a slack channel about the operation
slack_webhook_url=
#dumping website or app
tar cvzf $filename $webpath
#sending the dumps to the cloud
rclone copy  $spath/dumps $rclone_remote_name:webdump 2>> $spath/rclone-error.log
#Get some informations
info=$(du -sh $spath/dumps)
nb_files=$(ls -1 "$spath/dumps"|wc -l)
info="$info $nb_files files"
#Notify Slack channel
curl -X POST -H 'Content-type: application/json' --data-binary '{"text":"New Website Backup '"$info"' "}' $slack_webhook_url

#---------------------------------------------------------------------------------
