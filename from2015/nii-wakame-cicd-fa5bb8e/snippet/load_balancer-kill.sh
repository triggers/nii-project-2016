#!/bin/bash
#
# Usage:
#  $0 load_balancer_id
#
set -e
set -o pipefail
#set -u

## include

. /opt/axsh/wakame-vdc/client/mussel/test/helpers/retry.sh

## shell params

load_balancer_id="${1}"
: "${load_balancer_id:?"should not be empty"}"

## main

while read network_vif_id; do
  ${BASH_SOURCE[0]%/*}/load_balancer-unregister.sh "${load_balancer_id}" "${network_vif_id}" >/dev/null
done < <(${BASH_SOURCE[0]%/*}/load_balancer-inspect.sh "${load_balancer_id}" network_vif_id | awk '{print $3}')

mussel load_balancer destroy "${load_balancer_id}" >/dev/null
echo "${load_balancer_id} is shuttingdown..." >&2

retry_until [[ '"$(mussel load_balancer show "${load_balancer_id}" | egrep -w "^:state: terminated")"' ]]
echo load_balancer_id="${load_balancer_id}"
