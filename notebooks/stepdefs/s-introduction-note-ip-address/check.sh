#!/bin/bash


(
    fail()
    {
	echo "$*"
	exit 1
    }

    [ -f /home/centos/jenkins-instance-ip ] || fail "File /home/centos/jenkins-instance-ip not found"

    IP="$(< /home/centos/jenkins-instance-ip)"

    [[ "$IP" == *.*.*.* ]] || fail "$IP is not a valid IP address"

    # The next mussel commands returns current and deleted instances,
    # but only the current ones have the :address: field.
    inuse="$(mussel instance index | grep ":address:" | while read thelabel theip; do echo "$theip" ; done)"
    [[ "$inuse" == *$IP* ]] || fail "The address $IP is not currently used by any instancees"
)

if [ "$?" = "0" ]; then
    echo "TASK COMPLETED"
else
    echo "THIS TASK HAS NOT BEEN DONE"
fi
