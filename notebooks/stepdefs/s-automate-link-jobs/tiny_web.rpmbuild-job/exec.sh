ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
    $(declare -f check_param_value)

    check_param_value childProjects "tiny_web.rpmpublish" "${job}" && echo "Check [ ok ]" || {
        echo "Check [ fail ]"
    }
EOF
