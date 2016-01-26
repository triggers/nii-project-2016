#!/bin/bash
#
# Usage:
#  $0 instance_id
#
set -e
set -o pipefail
#set -u

## include

## shell params

security_group_id="${1}"
: "${security_group_id:?"should not be empty"}"

## get the sg's rule

rule="$(
  ${BASH_SOURCE[0]%/*}/security_group-inspect.sh "${security_group_id}" '^  [^:]' \
  | sed 's,^ *,,' \
  | tr '\n' ' '
)"
#: "${rule:?"should not be empty"}"

## show the rule

echo rule="\"${rule%% }\""
