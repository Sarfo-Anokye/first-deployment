#!/bin/bash

# Set variables
JENKINS_HOME="/var/lib/jenkins"   
S3_BUCKET="s3://jenkins-backup-buc"  
BACKUP_DIR="/tmp/jenkins_backups"  
TIMESTAMP=$(date +"%Y%m%d%H%M%S")  
BACKUP_FILE="jenkins-backup-${TIMESTAMP}.tar.gz"  

# Ensure the backup directory exists
mkdir -p $BACKUP_DIR

# Step 1: Archive the Jenkins home directory
echo "Archiving Jenkins home directory..."
tar -czf $BACKUP_DIR/$BACKUP_FILE -C $JENKINS_HOME .

# Step 2: Upload the backup to S3
echo "Uploading backup to S3 bucket..."
aws s3 cp $BACKUP_DIR/$BACKUP_FILE $S3_BUCKET/

# Step 3: Clean up old backups (optional, keep the last 7 backups)
echo "Cleaning up old backups (keeping last 7)..."
aws s3 ls $S3_BUCKET/ | sort | head -n -7 | awk '{print $4}' | while read file; do
  echo "Deleting old backup: $file"
  aws s3 rm "s3://$S3_BUCKET/$file"
done

# Clean up local backup files
rm -rf $BACKUP_DIR

echo "Backup completed successfully!"
