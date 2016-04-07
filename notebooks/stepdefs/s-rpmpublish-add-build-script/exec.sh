ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF  2> /dev/null
    content="\$(grep 'command' /var/lib/jenkins/jobs/${job}/config.xml)"
    [[ ! -z \$content ]] && echo " Check [ ok]" || "Check [ fail ]"
EOF
