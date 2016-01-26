#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
set -u

instance_id=
while read instance_id; do
  ${BASH_SOURCE[0]%/*}/instance-kill.sh ${instance_id}
done < <(${BASH_SOURCE[0]%/*}/instance-ls.sh)
