ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
    $(declare -f check_param_value)

    all_types_added=false
    check_param_value name "image_id yum_host" ${job} && {
         echo "Added paramters: Passed"
     } || echo "Check [ fail ]"

    check_param_value defaultValue "wmi-centos1d64 10.0.2.100" ${job} && {
         echo "Added values: Passed"
     } || echo "Check [ fail ]"

EOF
