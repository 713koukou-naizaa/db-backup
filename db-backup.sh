#!/bin/bash

# filename: backup-db.sh
# brief: Backup database using mariadb-dump
# description: Backup database using mariadb-dump, compress it and delete old backups
# author: 713koukou-naizaa
# date: 025-01-21
# usage: ./backup-db.sh

# VARS
backupfolder=/path/to/backup/folder # backup folder
logfile=/path/to/logs/file.log # log file

db=db_to_backup # db name
user=user # username

current_date=$(date +%Y-%m-%d_%H-%M-%S) # date
keep_day=15 # no of days to store backup

sqlfile=$backupfolder/${db}-database-$current_date.sql
zipfile=$backupfolder/${db}-database-$current_date.zip

# create folder & file if not exist
mkdir -p $backupfolder
touch $logfile


# BACKUP START
echo [$current_date] [info] Starting Backup >> $logfile


# CONNECT & CREATE BACKUP
# ie. opt/lampp/bin/mariadb-dump || /usr/bin/mariadb-dump || /usr/local/bin/mariadb-dump
mariadb_dump_result=$(/path/to/mariadb-dump -u$user $db 2>&1)
mariadb_dump_code=$?
if [ $mariadb_dump_code == 0 ]; then # 0 = success
  echo [$current_date] [info] Sql dump created: $sqlfile >> $logfile
else # != 0 = error
  echo [$current_date] [error] mariadb-dump return non-zero code $mariadb_dump_code >> $logfile
  echo [$current_date] [debug] $mariadb_dump_result >> $logfile
  exit
fi


# COMPRESS BACKUP
zip_result=$(zip -r $zipfile . -i $sqlfile)
if [ $? == 0 ]; then # 0 = success
  echo [$current_date] [info] Backup successfully compressed: $zipfile >> $logfile
else # != 0 = error
  echo [$current_date] [error] Error compressing backup >> $logfile
  exit
fi


# BACKUP END
echo [$current_date] [info] Backup complete >> $logfile
echo -------------------------------------------------- >> $logfile


# DELETE OLD BACKUPS
find $backupfolder -mtime +$keep_day -delete
