#!/bin/bash

# BACKUP_PATH is your restic repo
BACKUP_PATH="/media/backup/restic"
BACKUP_LOG="/media/backup/restic.log"

# This path should be included in your paths_include.restic
TMP_PATH="/media/backup/tmp"

FILES_PATH="/YOUR_SCRIPT_FOLDER/paths_include.restic"
EXCLUDE_PATH="/YOUR_SCRIPT_FOLDER/paths_exclude.restic"
RESTIC_PATH="/YOUR_RESTIC_FOLDER/restic"

echo "Backup started" | tee -a $BACKUP_LOG

# Set some environment-variables for restic.
export RESTIC_PASSWORD="YOUR_RESTIC_REPO_PASSWORD"
export RESTIC_REPOSITORY=$BACKUP_PATH

# Just to make everything sure, if you're using multiple scripts like I do.
echo "$BACKUP_PATH" | tee -a $BACKUP_LOG

# Prepare some folders
mkdir $TMP_PATH
#mkdir $TMP_PATH/router
#mkdir $TMP_PATH/mysql

# Router Backup. I use it to backup some scripts from my OpenWRT-Router.
#rsync -a --delete root@router:/root/scripts $TMP_PATH/router | tee -a $BACKUP_LOG

# MySQL Backup. If you like to backup some Databases.
#mysqldump -u root -p'DB_PASSWORD' --opt owncloud > $TMP_PATH/mysql/owncloud.sql | tee -a $BACKUP_LOG

###########################
# The real backup-process
###########################
$RESTIC_PATH/restic backup --files-from $FILES_PATH --exclude-file=$EXCLUDE_PATH --exclude-caches | tee -a $BACKUP_LOG
###########################
###########################

# Remove the temporary folder. We don't need it anymore. Backups is done.
rm -r $TMP_PATH

# Write down the current date and time into your logfile.
# It's useful if your script runs via cronjob.
date +%Y-%m-%d:%H:%M:%S >> $BACKUP_LOG

# Set a new access-date/time to your backup-folder.
# Remove it, if you don't like it ;)
touch $BACKUP_PATH

echo "Backup ended" | tee -a $BACKUP_LOG

# End
echo "---------------------------" >> $BACKUP_LOG

#"Delete" Restic-Password with a random string from your environment-variables.
export RESTIC_PASSWORD="tzhujnh789237zasjkf829723tzfghsdhj"
