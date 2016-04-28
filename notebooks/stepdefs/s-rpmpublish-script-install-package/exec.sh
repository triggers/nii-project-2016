output="$(ssh -qi /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test1_passed=false
test2_passed=false

{
    check_find_line_with "sudo" "yum" "install" "httpd" && test1_passed=true
    check_find_line_with "sudo" "/etc/init.d/httpd" "start" && test2_passed=true
    check_find_line_with "sudo" "service" "httpd" "start" test2_passed=true


} <<< "${output}"

check_message $test1_passed "$rpmpublish_task_install_httpd_a"
check_message $test2_passed "$rpmpublish_task_install_httpd_b"
