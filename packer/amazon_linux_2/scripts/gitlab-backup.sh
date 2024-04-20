#!/bin/bash

# file: ansible/

GITLAB_CONFIG_DIR=/etc/gitlab
COMPANY=$(/bin/aws ec2 describe-instances --instance-id $(/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id) --query "Reservations[*].Instances[*].Tags[?Key=='Company'].Value" --output text)
S3_BUCKET=$(aws ssm get-parameter --name /${COMPANY}/s3_bucket --query 'Parameter.Value' --output text)

# Create Gitalb Backup and Upload into S3 Folder
/bin/gitlab-backup create DIRECTORY=gitlab-backups

BACKUP_FILE=$(ls /var/opt/gitlab/backups/ | sort -r | head -1 | cut -f -3 -d ".")

# Tar the Manual Config Files Needed for a Gitlab Restore
/bin/tar cvfP ${GITLAB_CONFIG_DIR}/${BACKUP_FILE}_config.tar \
    ${GITLAB_CONFIG_DIR}/gitlab.rb \
    ${GITLAB_CONFIG_DIR}/gitlab-secrets.json \
    ${GITLAB_CONFIG_DIR}/ssl

# Upload the file to S3 Encrypted
/bin/aws s3 cp ${GITLAB_CONFIG_DIR}/${BACKUP_FILE}_config.tar s3://${S3_BUCKET}/gitlab-backups/${BACKUP_FILE}_config.tar --sse AES256

# Remove the Local File After Upload
/bin/rm ${GITLAB_CONFIG_DIR}/${BACKUP_FILE}_config.tar
