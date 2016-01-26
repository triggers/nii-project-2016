#!/bin/bash
#
#
#
set -e
set -o pipefail
set -u

#

instance_ids=
load_balancer_ids=

ssh_key_id="${ssh_key_id:?"should not be empty"}"
security_group_id="${security_group_id:?"should not be empty"}"
network_id="nw-demo1"

#

{
  ${BASH_SOURCE[0]%/*}/ssh_key_pair-inspect.sh "${ssh_key_id}"        :id:
  ${BASH_SOURCE[0]%/*}/security_group-inspect.sh      "${security_group_id}" :id:
} >&2

##

### lb8080

eval "$(
  ${BASH_SOURCE[0]%/*}/runner-lb8080.sh
)"
load_balancer_ids="${load_balancer_ids} ${load_balancer_id}"

### lb80

eval "$(
  ${BASH_SOURCE[0]%/*}/runner-lb80.sh
)"
load_balancer_ids="${load_balancer_ids} ${load_balancer_id}"

##

### db

eval "$(
  ssh_key_id="${ssh_key_id}" \
  ${BASH_SOURCE[0]%/*}/runner-db.sh
)"
instance_ids="${instance_ids} ${instance_id}"

### php

eval "$(
  ssh_key_id="${ssh_key_id}" \
  ${BASH_SOURCE[0]%/*}/runner-php.sh "${load_balancer_ids}"
)"
instance_ids="${instance_ids} ${instance_id}"

##

${BASH_SOURCE[0]%/*}/instance-ps.sh "${instance_ids}"
${BASH_SOURCE[0]%/*}/load_balancer-ps.sh   "${load_balancer_ids}"
