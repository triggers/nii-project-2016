#!/bin/bash
#
# Usage:
#  $0 [load_balancer_id]
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

load_balancer_ids="${@:-""}"

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
 image_id="wmi-php1d64" \
 user_data="${BASH_SOURCE[0]%/*}/user_data_php.txt" \
 display_name="php" \
  ${BASH_SOURCE[0]%/*}/instance-run.sh
)"

trap "${BASH_SOURCE[0]%/*}/instance-kill.sh \"${instance_id}\"" ERR

{
  ${BASH_SOURCE[0]%/*}/instance-wait4ssh.sh "${instance_id}"
  ${BASH_SOURCE[0]%/*}/instance-exec.sh     "${instance_id}" < ${BASH_SOURCE[0]%/*}/provision-php.sh
} >&2

eval "$(
  ${BASH_SOURCE[0]%/*}/instance-get-vif.sh "${instance_id}"
)"

for load_balancer_id in ${load_balancer_ids}; do
  ${BASH_SOURCE[0]%/*}/load_balancer-register.sh "${load_balancer_id}" "${vif}"
done 

echo instance_id="${instance_id}"
