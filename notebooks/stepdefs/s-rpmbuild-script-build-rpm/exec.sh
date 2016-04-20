output="$(ssh -qi ../mykeypair root@10.0.2.100 cat ${job_config} 2> /dev/null)"

test_passed=false

check_find_line_with "rpmbuild" "-bb" "./rpmbuild/SPECS/tiny-web-example.spec" <<< "$output" && test_passed=true

if $test_passed ; then
    echo "Check [ ok ]"
else
    echo "Check [ fail ]"
fi
