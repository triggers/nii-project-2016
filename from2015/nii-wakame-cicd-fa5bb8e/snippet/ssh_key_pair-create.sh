#!/bin/bash
#
# Usage:
#  $0 [ sgrule.txt ]
#
set -e
set -o pipefail
#set -u

## include

## shell params

public_key="${1}"
: "${public_key:?"should not be empty"}"

##

ssh_key_pair_id="$(
  mussel ssh_key_pair create \
   --public-key "${public_key}" \
  | egrep ^:id: | awk '{print $2}'
)"
: "${ssh_key_pair_id?"should not be empty"}"

echo ssh_key_pair_id="${ssh_key_pair_id}"
