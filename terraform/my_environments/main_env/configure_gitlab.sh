#!/bin/bash

# have script get instance tag.  something in the tag should be able to referent something in the DB
# have that tag match something in the DB, then pull in this data... like url...

FILE=/etc/gitlab/gitlab.rb
URL="ex2.gltest.link"

# Stop Gitlab
gitlab-ctl stop

# Place proper variables into gitlab.rb file
sed -i -r "s/external_url 'https:\/\/gitlab.example.com'/external_url 'https:\/\/$URL'/g" $FILE
sed -i -r "s/# letsencrypt\['enable'\] = nil/letsencrypt\['enable'\] = true/g" $FILE
sed -i -r "s/# letsencrypt\['auto_renew'\] = true/letsencrypt\['auto_renew'\] = true/g" $FILE
sed -i -r "s/# letsencrypt\['auto_renew_hour'\] = 0/letsencrypt\['auto_renew_hour'\] = 6/g" $FILE
sed -i -r "s/# letsencrypt\['auto_renew_minute'\] = nil/letsencrypt\['auto_renew_minute'\] = 15/g" $FILE
sed -i -r "s/# letsencrypt\['auto_renew_day_of_month'\] = \"*\/4\"/letsencrypt\['auto_renew_day_of_month'\] = \"*\/5\"/g" $FILE

# Reconfigure and start Gitlab
gitlab-ctl reconfigure
gitlab-ctl start
