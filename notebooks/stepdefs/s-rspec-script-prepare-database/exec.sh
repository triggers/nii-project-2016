output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test_passed=false

check_find_line_with "mysqladmin" "create" "tiny_web_example" <<< "$output" && test_passed=true

check_message $test_passed "$rspec_task1"
