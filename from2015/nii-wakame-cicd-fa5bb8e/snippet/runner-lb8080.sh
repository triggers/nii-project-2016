#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
set -u

#

eval "$(
 max_connection="1000" \
 instance_port="8080" \
 instance_protocol="http" \
 port_maps="8080:http" \
 display_name="lb8080" \
  ${BASH_SOURCE[0]%/*}/load_balancer-run.sh
)"

trap "${BASH_SOURCE[0]%/*}/load_balancer-kill.sh \"${load_balancer_id}\"" ERR

echo load_balancer_id="${load_balancer_id}"
