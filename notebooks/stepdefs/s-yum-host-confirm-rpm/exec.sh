output="$(ssh -qi /home/centos/mykeypair root@${INSTANCE_IP} '[[ -f /root/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm ]]' 2> /dev/null)"

test_passed=$?
check_message $test_passed "RPM file exists"
pwd  1>&2
(
    cd .jobs
    # with -l, grep will output lines like: "j-1042/command"
    jobs="$(grep -l yum-host-confirm-rpm */command | cut -d / -f 1)"
    didcheck=false
    for j in $jobs; do
	# if input has "ls" and output has the target file name...
	grep -q "ls" "$j/input" && \
	    grep -q "example-0.1.0-1.el6.x86_64.rpm" "$j/output" \
	    && { didcheck=true ; break ; }
    done
    check_message $didcheck "Check for RPM file was performed"
)

