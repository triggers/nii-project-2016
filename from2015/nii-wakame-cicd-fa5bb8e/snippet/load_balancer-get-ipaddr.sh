#!/bin/bash
#
# Usage:
#  $0 load_balancer_id
#
set -e
set -o pipefail
#set -u

## include

## shell params

load_balancer_id="${1}"
: "${load_balancer_id:?"should not be empty"}"

## get the load_balancer's ipaddress

ipaddr="$(
  ${BASH_SOURCE[0]%/*}/load_balancer-inspect.sh "${load_balancer_id}" :address: \
  | awk '{print $2}' \
  | tr '\n' ','
)"
: "${ipaddr:?"should not be empty"}"

## show the load_balancer

ipaddr="${ipaddr%%,}"

echo ipaddr="${ipaddr}"
echo ipaddr_public="${ipaddr%,*}"
echo ipaddr_managed="${ipaddr#*,}"
