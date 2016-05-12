output="$(ssh -qi /home/centos/mykeypair root@${INSTANCE_IP} 'cat ${HOME}/rpmbuild/SPECS/example.spec' 2> /dev/null)"
[[ "$output" == *0.2.0* ]]
test_passed=$?
check_message $test_passed "Spec file modified to 0.2.0"
