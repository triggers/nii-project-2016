ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF  2> /dev/null
    $(declare -f check_find_line_with)
    check_find_line_with ${job} 1 mysqladmin create tiny_web_example && echo "Check [ ok ]" || echo "Check [ fail ]"
EOF
