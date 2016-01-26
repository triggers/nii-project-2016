#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
# set-u

# include

. /opt/axsh/wakame-vdc/client/mussel/test/helpers/retry.sh

## shell params

balance_algorithm="${balance_algorithm:-"leastconn"}"
engine="${engine:-"haproxy"}"
max_connection="${max_connection:-"1000"}"
instance_port="${instance_port:-"80"}"
instance_protocol="${instance_protocol:-"http"}"
#port_maps="${port_maps:-"80:http,8080:http"}"
port_maps="${port_maps:-"80:http"}"

display_name="${display_name:-""}"

## create a load_balancer

load_balancer_id="$(
  mussel load_balancer create \
   --balance-algorithm "${balance_algorithm}" \
   --engine            "${engine}"            \
   --instance-port     "${instance_port}"     \
   --instance-protocol "${instance_protocol}" \
   --max-connection    "${max_connection}"    \
   --display-name      "${display_name}"      \
   $(
    IFS=,
    for i in ${port_maps}; do
      echo --port     ${i%%:*}
      echo --protocol ${i##*:}
    done
   ) \
  | egrep ^:id: | awk '{print $2}'
)"

: "${load_balancer_id:?"load_balancer is empty"}"
echo "${load_balancer_id} is initializing..." >&2

## wait for the load_balancer to be running

retry_until [[ '"$(mussel load_balancer show "${load_balancer_id}" | egrep -w "^:state: running")"' ]]
echo load_balancer_id="${load_balancer_id}"
