#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
#set -u

## include

## shell params

state="${1:-alive}"

## backup an instance

mussel instance index --state "${state}" \
 | egrep :id: \
 | awk '{print $3}'
