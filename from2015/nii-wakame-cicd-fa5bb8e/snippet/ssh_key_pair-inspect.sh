#!/bin/bash
#
# Usage:
#  $0 ssh_key_pair_id [keyaord]
#
set -e
set -o pipefail
#set -u

## include

## shell params

ssh_key_pair_id="${1}"
: "${ssh_key_pair_id:?"should not be empty"}"
keyword="${2:-""}"

## show the ssh_key_pair

output="$(mussel ssh_key_pair show "${ssh_key_pair_id}")"

# when sg has no rules, rule does not exist.
egrep "${keyword}" <<< "${output}" || :
