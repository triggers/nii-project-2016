ssh -qi ../mykeypair root@10.0.2.100 <<EOF
    $(declare -f check_find_line_with)
    check_find_line_with ${job} 1 "sudo" "yum" "install" "yum-utils" && echo "Check [ ok ]" || echo "Check [ fail ]"
EOF
