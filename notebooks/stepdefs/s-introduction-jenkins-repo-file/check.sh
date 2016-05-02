#!/bin/bash

source /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
source /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh

: ${IP:=10.0.2.100}
ssh -qi ../mykeypair root@$IP '[ -f /etc/yum.repos.d/jenkins.repo ]'

check_message "$?" "Downloaded jenkins repo"
