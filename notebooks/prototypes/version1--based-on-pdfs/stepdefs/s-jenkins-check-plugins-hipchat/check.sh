#!/bin/bash
. ./stepdefs/jenkins-utility/functions.sh

SSH="ssh root@10.0.2.100 -i /home/centos/mykeypair"

${SSH} <<EOF 2> /dev/null

$(declare -f check_plugins_exists)

if ! check_plugins_exists "hipchat" ; then
    echo "Missing plugin."
else
    echo "Configuration is correct"
fi

EOF
