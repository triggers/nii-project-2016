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

#

eval "$(
 ssh_key_id="${ssh_key_id}" \
 vifs="${BASH_SOURCE[0]%/*}/vifs.json" \
 memory_size="1024" \
 image_id="wmi-ciserver1d64" \
 user_data="${BASH_SOURCE[0]%/*}/user_data_ci.txt" \
 display_name="ci" \
  ${BASH_SOURCE[0]%/*}/instance-run.sh
)"

trap "${BASH_SOURCE[0]%/*}/instance-kill.sh \"${instance_id}\"" ERR

{
  ${BASH_SOURCE[0]%/*}/instance-wait4ssh.sh "${instance_id}"
  if [[ -f "${BASH_SOURCE[0]%/*}/provision-ci-pre.sh" ]]; then
    ${BASH_SOURCE[0]%/*}/instance-exec.sh   "${instance_id}" < "${BASH_SOURCE[0]%/*}/provision-ci-pre.sh"
  fi
  ${BASH_SOURCE[0]%/*}/instance-exec.sh     "${instance_id}" < ${BASH_SOURCE[0]%/*}/provision-ci.sh
  if [[ -f "${BASH_SOURCE[0]%/*}/provision-ci-post.sh" ]]; then
    ${BASH_SOURCE[0]%/*}/instance-exec.sh   "${instance_id}" < "${BASH_SOURCE[0]%/*}/provision-ci-post.sh"
  fi
} >&2

echo instance_id="${instance_id}"
