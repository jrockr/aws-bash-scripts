#!/bin/bash
# list all the table name in the array 
tables=( x y z )
for i in "${tables[@]}"
do
	backup=`aws dynamodb create-backup --table-name $i --backup-name $i+Backup`
  arn=`echo backup | jq -r '.BackupDetails | {BackupArn}' | jq -r '.BackupArn'`
  aws dynamodb restore-table-from-backup --target-table-name $i --backup-arn $arn
done
