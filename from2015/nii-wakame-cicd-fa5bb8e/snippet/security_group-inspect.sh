#!/bin/bash
#
# Usage:
#  $0 security_group_id [keyaord]
#
set -e
set -o pipefail
#set -u

## include

## shell params

security_group_id="${1}"
: "${security_group_id:?"should not be empty"}"
keyword="${2:-""}"

## show the security_group

output="$(mussel security_group show "${security_group_id}")"

# when sg has no rules, rule does not exist.
egrep "${keyword}" <<< "${output}" || :
