output="$(ssh -i /home/centos/mykeypair root@10.0.2.100 grep command ${job_config} 2> /dev/null)"

if [[ ! -z "$output" ]] ; then
    echo "Check [ ok]"
else
    echo "Check [ fail ]"
fi
