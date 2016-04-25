ssh -i /home/centos/mykeypair root@10.0.2.100 "[[ -d /var/lib/jenkins/jobs/${job} ]]" 2> /dev/null

check_message $? "$create_job_status"
