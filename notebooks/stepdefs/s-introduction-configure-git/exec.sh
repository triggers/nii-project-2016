ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF  2> /dev/null
    $(declare -f check_not_empty)

    check_not_empty system_config "$filename" token && echo "Check [ ok ]" || echo "Check [ fail ]"
    check_not_empty system_config "$filename" room && echo "Check [ ok ]" || echo "Check [ fail ]"
EOF
