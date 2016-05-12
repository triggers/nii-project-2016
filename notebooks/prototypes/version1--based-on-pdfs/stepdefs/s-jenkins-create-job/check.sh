#!/bin/bash
. ./stepdefs/jenkins-utility/functions.sh

JOB=${1:-"sample"}
XML_FILE="sample-0.xml"
SSH="ssh root@10.0.2.100 -i /home/centos/mykeypair"

xml_to_vm

${SSH} <<EOF 2> /dev/null

if [[ ! -d /var/lib/jenkins/jobs/${JOB} ]] ; then
    echo "Something went wrong." 
else 
    echo "Configuration is correct."
fi

EOF
