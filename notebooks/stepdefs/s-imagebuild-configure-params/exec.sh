output="$(ssh -qi ../mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test1_passed=false
test2_passed=false

check_param_value name "image_id yum_host" <<< "$output" && test1_passed=true
check_param_value defaultValue "wmi-centos1d64 10.0.2.100" <<< "$output" && test2_passed=true

if $test1_passed ; then
    echo "Param Names: passed"
else
    echo "Check [ fail ]"
fi

if $test2_passed ; then
    echo "Param Valus: passed"
else
    echo "Check [ fail ]"
fi
