#!/bin/bash

source /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
source /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh

out="$(ssh -qi ../mykeypair root@10.0.2.100 'java -version' 2>&1)"
echo "$out"

[[ "$out" == *java*version*1.8* ]]
test_passed="$?"
check_message $test_passed "Installed Java"
