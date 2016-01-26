#!/bin/bash
#
# Usage:
#  $0 security_group_id
#
set -e
set -o pipefail
#set -u

## shell params

security_group_id="${1}"
: "${security_group_id:?"should not be empty"}"

## main

mussel security_group destroy "${security_group_id}" >/dev/null
echo security_group_id="${security_group_id}"
