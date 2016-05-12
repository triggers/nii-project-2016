#!/bin/bash

. ./stepdefs/jenkins-utility/functions.sh

# Doit file for job that runs integration test used in tiny_web_example
# Tasks:
#  Copy xml into instance jenkins is running on.
#  Create job, tiny_web.integration using predefined configuration file

ssh="ssh root@10.0.2.100 -i /home/centos/mykeypair"
job=tiny_web.integration
xml_file=tiny_web.integration.xml

xml_to_vm

${ssh} <<EOF 2> /dev/null

$(declare -f reset_job)
$(declare -f check_client_exists)

check_client_exists
reset_job ${job} ${xml_file}

EOF
