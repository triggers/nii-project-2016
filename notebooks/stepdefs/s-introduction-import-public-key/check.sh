#!/bin/bash

source /home/centos/notebooks/stepdefs/jenkins-utility/message.conf
source /home/centos/notebooks/stepdefs/jenkins-utility/check_message.sh

KEYFILE=/tmp/jenkins-ci.org.key
[ -f $KEYFILE ] || \
    wget http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key \
	 -O $KEYFILE 2>/dev/null

KEYID=$(echo $(gpg --throw-keyids < $KEYFILE 2>/tmp/gpg.stderr)|cut -c11-18|tr [A-Z] [a-z])

# from http://unix.stackexchange.com/questions/21226/how-can-i-verify-that-a-pgp-key-is-imported-into-rpm

ssh -qi ../mykeypair root@10.0.2.100 <<EOF 2>/dev/null
rpm -q gpg-pubkey-$KEYID
EOF

# The above used to give excess output, but not I cannot duplicate the problem.

check_message "$?" "Public key imported"
