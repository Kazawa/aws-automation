#!/bin/bash

# file: ansible/

GL_BACKUP_FILE=$1
GL_BACKUP_FILE_SHORT=${GL_BACKUP_FILE:0:-18}
GL_BACKUP_CONFIG_FILE=${GL_BACKUP_FILE:0:-4}
GL_BACKUP_VERSION=${GL_BACKUP_FILE:22:-21}
GL_INSTALLED_VERSION=$(/bin/rpm -qa | grep gitlab | cut -d'-' -f 3)
GL_CONFIG_DIR=/etc/gitlab
GL_BACKUP_DIR=/var/opt/gitlab/backups
COMPANY=$(/bin/aws ec2 describe-instances --instance-id $(/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id) --query "Reservations[*].Instances[*].Tags[?Key=='Company'].Value" --output text)
S3_BUCKET=$(aws ssm get-parameter --name /${COMPANY}/s3_bucket --query 'Parameter.Value' --output text)

# Install Gitalb Version to Match Backup Version
if [ "${GL_BACKUP_VERSION}" == "${GL_INSTALLED_VERSION}" ]; then
    /bin/echo "Backup File Matches Server Installation... Skipping"
    :
else
    /bin/echo "Backup File Differs from Server Insallation."
    /bin/echo "Stopping and Erasing Current Gitalb Version..."
    /bin/gitlab-ctl stop
    /bin/yum erase gitlab-ee -y
    /bin/rm -rf /var/opt/gitlab /etc/gitlab /opt/gitlab
    /bin/echo "Installing Gitlab..."
    /bin/yum install gitlab-ee-${GL_BACKUP_VERSION} -y
fi

# Remove Default GitLab Installation Files
/bin/rm -rf \
    $GL_CONFIG_DIR/config_backup \
    $GL_CONFIG_DIR/gitlab.rb \
    $GL_CONFIG_DIR/gitlab-secrets.json \
    $GL_CONFIG_DIR/initial_root_password

# Download and Restore Gitlab Backup Configuration File from S3
/bin/echo "Downloading Gitlab Backup Configuration from S3..."
/bin/aws s3 cp s3://${S3_BUCKET}/gitlab-backups/${GL_BACKUP_CONFIG_FILE}_config.tar ${GL_CONFIG_DIR}/${GL_BACKUP_CONFIG_FILE}_config.tar
/bin/tar xvfP ${GL_CONFIG_DIR}/${GL_BACKUP_CONFIG_FILE}_config.tar
/bin/rm ${GL_CONFIG_DIR}/${GL_BACKUP_CONFIG_FILE}_config.tar

# Per GitLab Pre-Requisite, Reconfigure and Start Before Restoring the Backup
/bin/gitlab-ctl reconfigure
/bin/gitlab-ctl start

# Copy Gitlab Backup File from S3
/bin/echo "Downloading Gitlab Backup File from S3..."
/bin/aws s3 cp s3://${S3_BUCKET}/gitlab-backups/${GL_BACKUP_FILE} ${GL_BACKUP_DIR}/${GL_BACKUP_FILE}
/bin/chown git:git ${GL_BACKUP_DIR}/${GL_BACKUP_FILE}
/bin/chmod 600 ${GL_BACKUP_DIR}/${GL_BACKUP_FILE}

# Restore GitLab Backup File
/bin/echo "Starting GitLab Restore..."
/bin/gitlab-ctl stop puma
/bin/gitlab-ctl stop sidekiq
/bin/gitlab-backup restore BACKUP=${GL_BACKUP_FILE_SHORT} force=yes
/bin/gitlab-ctl reconfigure
/bin/gitlab-ctl restart
