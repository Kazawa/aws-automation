#!/bin/bash

# have script get instance tag.  something in the tag should be able to referent something in the DB
# have that tag match something in the DB, then pull in this data... like url...

# Wait for Cloud-Init to finish
/bin/cloud-init status --wait

FILE=/etc/gitlab/gitlab.rb
# Get the value(s) from the database in the future.
VAR_COMPANY=$(/bin/aws ec2 describe-instances --instance-id $(/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id) --query "Reservations[*].Instances[*].Tags[?Key=='Company'].Value" --output text)
VAR_EXTERNAL_URL="https://${VAR_COMPANY}.gltest.link"
VAR_REGION=$(curl http://169.254.169.254/latest/meta-data/placement/region)
VAR_S3_BUCKET=$(aws ssm get-parameter --name /${VAR_COMPANY}/s3_bucket --query 'Parameter.Value' --output text)
VAR_SMTP_USER_NAME=$(aws ssm get-parameter --name /common/smtp_access_key_id --query 'Parameter.Value' --with-decryption --output text)
VAR_SMTP__PASSWORD=$(aws ssm get-parameter --name /common/smtp_password --query 'Parameter.Value' --with-decryption --output text)

# Stop Gitlab
sudo gitlab-ctl stop

# Place proper variables into gitlab.rb file
sudo sed -i -r "s|VAR_EXTERNAL_URL|$VAR_EXTERNAL_URL|g" $FILE
sudo sed -i -r "s|VAR_REGION|$VAR_REGION|g" $FILE
sudo sed -i -r "s|VAR_S3_BUCKET|$VAR_S3_BUCKET|g" $FILE
sudo sed -i -r "s|VAR_SMTP_USER_NAME|$VAR_SMTP_USER_NAME|g" $FILE
sudo sed -i -r "s|VAR_SMTP__PASSWORD|$VAR_SMTP__PASSWORD|g" $FILE

# Reconfigure and start Gitlab
sudo gitlab-ctl reconfigure
sudo gitlab-ctl start

sudo systemctl disable gitlab-config

# Place value of Gitlab-Runner token ito AWS Parameter Store
RUNNER_TOKEN=$(sudo gitlab-rails runner -e production "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token")
sudo /bin/aws ssm put-parameter --name /$(hostname --fqdn | cut -f1 -d"-")/gitlab_runner_token --type String --overwrite --value $RUNNER_TOKEN
