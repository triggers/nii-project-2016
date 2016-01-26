#!/bin/bash
#
# Usage:
#  $0 [ sgrule.txt ]
#
set -e
set -o pipefail
set -u

## include

## shell params

rule="${rule:-"sgrule.txt"}"

##

security_group_id="$(
  mussel security_group create \
   --rule "${rule}" \
  | egrep ^:id: | awk '{print $2}'
)"
: "${security_group_id?"should not be empty"}"

echo security_group_id="${security_group_id}"
