output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test_passed=false

check_find_line_with "bundle" "exec" "rspec" "./spec/comment_spec.rb"  <<< "$output" && test_passed=true

if $test_passed ; then
    echo "Check [ ok ]"
else
    echo "Check [ fail ]"
fi
