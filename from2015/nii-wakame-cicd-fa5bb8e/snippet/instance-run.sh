#!/bin/bash
#
# Usage:
#  ssh_key_id=ssh-*** \
#   $0
#
set -e
set -o pipefail
#set -u

## include

. /opt/axsh/wakame-vdc/client/mussel/test/helpers/retry.sh

## shell params

cpu_cores="${cpu_cores:-"1"}"
hypervisor="${hypervisor:-"kvm"}"
image_id="${image_id:-"wmi-centos1d64"}"
memory_size="${memory_size:-"256"}"

ssh_key_id="${ssh_key_id:?"should not be empty"}"
vifs="${vifs:-"vifs.json"}"
user_data="${user_data:-"/dev/null"}" # user_data_mysqld.txt

display_name="${display_name:-""}"

## create an instance

instance_id="$(
  # make sure to set empty to shell params for mussel
  cpu_cores=""    \
  hypervisor=""   \
  image_id=""     \
  memory_size=""  \
  ssh_key_id=""   \
  vifs=""         \
  user_data=""    \
  display_name="" \
  \
  mussel instance create \
   --cpu-cores    "${cpu_cores}"    \
   --hypervisor   "${hypervisor}"   \
   --image-id     "${image_id}"     \
   --memory-size  "${memory_size}"  \
   --ssh-key-id   "${ssh_key_id}"   \
   --vifs         "${vifs}"         \
   --user-data    "${user_data}"    \
   --display-name "${display_name}" \
  | egrep ^:id: | awk '{print $2}'
)"
: "${instance_id:?"should not be empty"}"
echo "${instance_id} is initializing..." >&2

## wait for the instance to be running

retry_until [[ '"$(mussel instance show "${instance_id}" | egrep -w "^:state: running")"' ]]
echo instance_id="${instance_id}"
