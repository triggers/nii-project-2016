output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test1_passed=false
test2_passed=false
test3_passed=false

check_param_value projects "tiny_web.integration" <<< "$output" && test1_passed=true
check_param_value condition "SUCCESS" <<< "$output" && test2_passed=true
check_param_value propertiesFile "\${WORKSPACE}/\${BUILD_TAG}" <<< "$output" && test3_passed=true

if $test1_passed ; then
    echo "Check [ ok ]"
else
    echo "Check [ fail ]"
fi

if $test2_passed ; then
    echo "Check [ ok ]"
else
    echo "Check [ fail ]"
fi

if $test3_passed ; then
    echo "Check [ ok ]"
else
    echo "Check [ fail ]"
fi






