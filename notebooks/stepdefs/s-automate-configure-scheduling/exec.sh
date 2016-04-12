
ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
    $(declare -f check_param_value)

    # Represent a space so that the check function does not evaluate the token
    # as multiple tokens

    check_param_value spec "5$sp*$sp*$sp*$sp*" "${job}" && echo "Check [ ok ]" || {
        echo "Check [ fail ]"
    }

EOF
