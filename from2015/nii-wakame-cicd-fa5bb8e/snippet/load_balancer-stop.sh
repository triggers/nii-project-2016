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

## create an load_balancer

mussel load_balancer poweroff "${load_balancer_id}" >/dev/null
echo "${load_balancer_id} is halting..." >&2

retry_until [[ '"$(mussel load_balancer show "${load_balancer_id}" | egrep -w "^:state: halted")"' ]]
echo load_balancer_id="${load_balancer_id}"
