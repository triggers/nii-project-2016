#!/bin/bash

: ${IP:=10.0.2.100}

ssh -qi /home/centos/mykeypair root@${IP} <<'EOS' 2> /dev/null

if curl -I -s http://localhost:8080/ | grep -q "200 OK" ; then
    echo "TASK COMPLETED"
else
    echo "THIS TASK HAS NOT BEEN DONE"
fi
EOS
