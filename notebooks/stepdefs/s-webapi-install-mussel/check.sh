#!/bin/bash

ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF  2> /dev/null
    [[ -f /opt/axsh/wakame-vdc/client/mussel/bin/mussel ]] && echo "Check [ ok]" || echo "Check [ fail ]"
EOF
