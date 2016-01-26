#!/bin/bash
#
# Usage:
#  $0 instance_id [keyaord]
#
set -e
set -o pipefail
#set -u

## include

## shell params

instance_id="${1}"
: "${instance_id:?"should not be empty"}"
keyword="${2:-""}"

## show the instance

mussel instance show "${instance_id}" | egrep "${keyword}"
