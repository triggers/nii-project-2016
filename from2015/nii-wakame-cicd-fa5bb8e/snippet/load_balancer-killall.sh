#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
set -u

load_balancer_id=
while read load_balancer_id; do
  ${BASH_SOURCE[0]%/*}/load_balancer-kill.sh ${load_balancer_id}
done < <(${BASH_SOURCE[0]%/*}/load_balancer-ls.sh)
