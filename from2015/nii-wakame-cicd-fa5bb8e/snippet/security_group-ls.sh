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

service_type="${1:-std}"

## index

mussel security_group index --service-type ${service_type} \
 | egrep :id: \
 | awk '{print $3}'
