ssh -i /home/centos/mykeypair root@10.0.2.100 "[[ -d /var/lib/jenkins/jobs/${job} ]]" 2> /dev/null

if [[ $? == 0 ]] ; then
    echo "This task has been done"
else
    echo "Job Missing"
fi
