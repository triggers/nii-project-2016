output="$(ssh -qi /home/centos/mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test1_passed=false
test2_passed=false

{
    check_find_line_with "sudo" "yum" "install" "httpd" && test1_passed=true
    check_find_line_with "sudo" "/etc/init.d/httpd" "start" && test2_passed=true
    check_find_line_with "sudo" "service" "httpd" "start" test2_passed=true


} <<< "${output}"

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

