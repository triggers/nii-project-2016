#!/bin/bash
#
# Usage:
#  $0 instance_id
#
set -e
set -o pipefail
#set -u

## include

. /opt/axsh/wakame-vdc/client/mussel/test/helpers/retry.sh

## shell params

instance_id="${1}"
: "${instance_id:?"should not be empty"}"

## get the instance's ipaddress

ipaddr=
eval "$(
  ${BASH_SOURCE[0]%/*}/instance-get-ipaddr.sh "${instance_id}"
)"
: "${ipaddr:?"should not be empty"}"

## wait...

{
  wait_for_network_to_be_ready "${ipaddr}"
  wait_for_sshd_to_be_ready    "${ipaddr}"
} >&2
echo ipaddr="${ipaddr}"
