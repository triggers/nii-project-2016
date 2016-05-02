#!/bin/bash

source /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
source /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh

: ${IP:=10.0.2.100}

output="$(ssh -qi /home/centos/mykeypair root@${IP} 'curl -I -s http://localhost:8080/')"

test_passed=fail

grep -q "200 OK" <<< "$output" && test_passed=true

check_message $test_passed "Jenkins running"
