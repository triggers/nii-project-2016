ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
    $(declare -f check_param_value)

    check_param_value projects "tiny_web.integration" "${job}" && echo "Check [ ok ]" || {
        echo "Check [ fail ]"
    }
    check_param_value condition "SUCCESS" "${job}" && echo "Check [ ok ]" || {
        echo "Check [ fail ]"
    }
    check_param_value propertiesFile "\${WORKSPACE}/\${BUILD_TAG}" "${job}" && echo "Check [ ok ]" || {
        echo "Check [ fail ]"
    }
EOF
