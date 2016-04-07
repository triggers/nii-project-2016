ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
    $(declare -f check_param_value)

    all_types_added=false
    check_param_value notificationType "SUCCESS STARTED FAILURE" ${job} && {
         echo "Added notifications: Passed"
         all_types_added=true
     } || echo "Check [ fail ]"

    # We need to make sure the jobs are created to pass this test as well.
    \$all_types_added && ! check_param_value notifyEnabled "false" ${job} && {
        echo "Enabled notifications: Passed"
     } || echo "Check [ fail ]"
EOF
