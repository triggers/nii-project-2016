#!/bin/bash
#
# Usage:
#  $0 ssh_key_pair_id
#
set -e
set -o pipefail
#set -u

## shell params

ssh_key_pair_id="${1}"
: "${ssh_key_pair_id:?"should not be empty"}"

## main

mussel ssh_key_pair destroy "${ssh_key_pair_id}" >/dev/null
echo ssh_key_pair_id="${ssh_key_pair_id}"
