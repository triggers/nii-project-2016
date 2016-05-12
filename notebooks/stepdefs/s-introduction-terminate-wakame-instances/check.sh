#!/bin/bash

. /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
. /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh 

check-wakame.sh

test_passed=$?
check_message $test_passed "Instance terminated"
