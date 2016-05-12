#!/bin/bash

source /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
source /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh

ssh -qi ../mykeypair root@10.0.2.100 'rpm -qa' | grep jenkins

check_message "$?" "Installed Jenkins"
