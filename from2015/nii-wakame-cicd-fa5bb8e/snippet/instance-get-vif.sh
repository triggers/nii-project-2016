#!/bin/bash
#
# Usage:
#  $0 instance_id
#
set -e
set -o pipefail
#set -u

## include

## shell params

instance_id="${1}"
: "${instance_id:?"should not be empty"}"

## get the instance's vifs

vif="$(
  ${BASH_SOURCE[0]%/*}/instance-inspect.sh "${instance_id}" :vif_id: \
  | awk '{print $3}' \
  | tr '\n' ','
)"
: "${vif:?"should not be empty"}"

## show the instance

echo vif="${vif%%,}"
