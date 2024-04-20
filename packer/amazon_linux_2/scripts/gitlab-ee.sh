#!/bin/bash


sudo yum install -y curl policycoreutils-python openssh-server openssh-clients perl firewalld
# Check if opening the firewall is needed with: sudo systemctl status firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld
sudo firewall-cmd --list-all

# Mail config
sudo yum install postfix -y
sudo systemctl enable postfix
sudo systemctl start postfix

# add repository
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
sudo yum clean all

# install gitlab-ee
sudo yum install -y gitlab-ee

#echo "-----Your Login Password-----"
#sudo cat /etc/gitlab/initial_root_password
