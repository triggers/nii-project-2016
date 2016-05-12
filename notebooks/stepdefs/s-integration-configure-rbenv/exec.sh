output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test1_passed=false
test2_passed=false

check_find_line_with "version" "2.0.0-p598" <<< "$output" && test1_passed=true
check_find_line_with "gem__list" "bundler" "rake" <<< "$output" && test2_passed=true

if $test1_passed ; then
    echo "Version: Passed"
else
    echo "Check [ failed ]"
fi

if $test2_passed ; then
    echo "Gems: Passed"
else
    echo "Check [ failed ]"
fi
