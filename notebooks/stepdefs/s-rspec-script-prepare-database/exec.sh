output="$(ssh -i /home/centos/mykeypair root@${INSTANCE_IP} cat ${job_config} 2> /dev/null)"

test_passed=false

check_find_line_with "mysqladmin" "create" "tiny_web_example" <<< "$output" && test_passed=true

check_message $test_passed "Database gets prepared"
