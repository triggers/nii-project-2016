#!/bin/bash
#
# Usage:
#  $0 load_balancer_id [keyaord]
#
set -e
set -o pipefail
#set -u

## include

## shell params

load_balancer_id="${1}"
: "${load_balancer_id:?"should not be empty"}"
keyword="${2:-""}"

## show the load_balancer

mussel load_balancer show "${load_balancer_id}" | egrep "${keyword}"
