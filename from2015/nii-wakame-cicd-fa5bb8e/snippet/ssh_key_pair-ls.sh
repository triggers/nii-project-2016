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

## index

mussel ssh_key_pair index \
 | egrep :id: \
 | awk '{print $3}'
