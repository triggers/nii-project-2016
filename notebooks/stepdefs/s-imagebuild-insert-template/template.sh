#!/bin/bash

# set -euox

. $(dirname $0)/stepdata.conf
. /home/centos/notebooks/stepdefs/jenkins-utility/xml-utility.sh

reboot=false

function load_config() {
    local file="/var/lib/jenkins/jobs/${job}/config.xml"
    local element_name="${1}" element_value="${2}"
    # The sed here preserves end of line backslashes from being stripped by the bash
    # on the other side of ssh
    sed 's,\\$,BaCkSlash,g'  <<EOF | ssh -i /home/centos/mykeypair root@10.0.2.100 2> /dev/null
        $(declare -f xml_load_backup)

        value="\$(sed 's,BaCkSlash,\\\\,g' <<"XML_BLOCK"
$element_value
XML_BLOCK
)"
        xml_load_backup "${job}" "${file}" "${element_name}" "\${value}"
EOF
}

echo "Loading provided settings..."
[[ ${#xpaths} -eq 0 ]] || {
    for xpath in "${xpaths[@]}" ; do
        load_config "${xpath##*/}" "$(cat $(dirname $0)/xml-data/${xpath##*/}.data)"
    done
}
