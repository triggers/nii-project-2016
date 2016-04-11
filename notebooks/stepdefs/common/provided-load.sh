#!/bin/bash

# set -euox

. /home/centos/notebooks/stepdefs/jenkins-utility/xml-utility.sh

reboot=false

function load_config() {
    local file="/var/lib/jenkins/jobs/${job}/config.xml"
    local element_name="${1}" element_value="${2}"
    ssh -i /home/centos/mykeypair root@10.0.2.100 <<EOF  2> /dev/null
        $(declare -f xml_load_backup)
        $(declare -f xml_replace_case)
        $(declare -f xml_insert_case)

        value="\$(cat <<"XML_BLOCK"
$element_value
XML_BLOCK
)"
        xml_load_backup "${job}" "${file}" "${element_name}" "\${value}"
EOF
}

[[ ${#xpaths} -eq 0 ]] || {
    for xpath in "${xpaths[@]}" ; do
	echo "Loading path ${xpath}."
        load_config "${xpath##*/}" "$(cat $(dirname $0)/xml-data/${xpath##*/}.data)"
    done
}
