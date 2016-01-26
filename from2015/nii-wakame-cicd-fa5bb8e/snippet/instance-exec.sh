#!/bin/bash
#
# Usage:
#  $0 instance_id
#
set -e
set -o pipefail
#set -u

## include

. /opt/axsh/wakame-vdc/client/mussel/test/helpers/ssh.sh

## shell params

ssh_user="${ssh_user:-"root"}"
ssh_key="${ssh_key:-"mykeypair"}"

instance_id="${1}"
: "${instance_id:?"should not be empty"}"

## get the instance's ipaddress

ipaddr="$(
  mussel instance show "${instance_id}" \
  | egrep -w :address: | awk '{print $2}'
)"
: "${ipaddr:?"should not be empty"}"

## ssh to the instance

shift
ssh "${ssh_user}@${ipaddr}" -i "${ssh_key}" "${@}"
