#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
set -u

#

. /opt/axsh/wakame-vdc/client/mussel/functions
load_musselrc

#

ssh_key_id="${ssh_key_id:?"should not be empty"}"
security_group_id="${security_group_id:?"should not be empty"}"
network_id="${network_id:-"nw-demo1"}"

##

cat <<EOS > ${BASH_SOURCE[0]%/*}/vifs.json
{
  "eth0":{"network":"${network_id}","security_groups":"${security_group_id}"}
}
EOS

#

eval "$(
 ssh_key_id="${ssh_key_id}" \
 vifs="${BASH_SOURCE[0]%/*}/vifs.json" \
 memory_size="512" \
 image_id="wmi-mysqld1d64" \
 user_data="${BASH_SOURCE[0]%/*}/user_data_mysqld.txt" \
 display_name="db" \
  ${BASH_SOURCE[0]%/*}/instance-run.sh
)"

trap "${BASH_SOURCE[0]%/*}/instance-kill.sh \"${instance_id}\"" ERR

eval "$(${BASH_SOURCE[0]%/*}/instance-get-ipaddr.sh "${instance_id}")"

{
  ${BASH_SOURCE[0]%/*}/instance-wait4ssh.sh "${instance_id}"
  ${BASH_SOURCE[0]%/*}/instance-exec.sh     "${instance_id}" < ${BASH_SOURCE[0]%/*}/provision-mysqld.sh
} >&2

{
  echo generating user_data_app.txt...
  echo "DB_HOST=${ipaddr}" | tee user_data_app.txt
  echo generating user_data_php.txt...
  echo "DB_HOST=${ipaddr}" | tee user_data_php.txt
} >&2

echo instance_id="${instance_id}"
