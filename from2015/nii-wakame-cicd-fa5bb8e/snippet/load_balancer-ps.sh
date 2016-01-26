#!/bin/bash
#
# Usage:
#  $0
#
set -e
set -o pipefail
#set -u

## include

## shell params

load_balancer_ids="${@:-""}"
state="alive"

## ps

fmt='%-11s %-19s %-12s %-12s %-15s %-15s %-5s %-8s %-15s %s\n'
printf "${fmt}" INSTANCE CREATED STATUS STATE PUBLIC_IPADDR MANAGED_IPADDR PORT PROTOCOL NAME TARGET_VIF

if [[ -n "${load_balancer_ids}" ]]; then
  output="${load_balancer_ids}"
else
  output="$(${BASH_SOURCE[0]%/*}/load_balancer-ls.sh "${state}")"
fi

for uuid in ${output}; do
        output="$(${BASH_SOURCE[0]%/*}/load_balancer-inspect.sh ${uuid})"
        status="$(egrep "^:status:"          <<< "${output}" | awk '{print $2}')"
         state="$(egrep "^:state:"           <<< "${output}" | awk '{print $2}')"
    created_at="$(egrep "^:created_at:"      <<< "${output}" | cut -d' ' -f2-3)"; created_at="${created_at/ /T}"; created_at="${created_at%%.*}"
         ports="$(egrep  ":port:"            <<< "${output}" | awk '{print $3}' | tr '\n', ',')"
     protocols="$(egrep  ":protocol:"        <<< "${output}" | awk '{print $2}' | tr '\n', ',')"
  display_name="$(egrep "^:display_name:"    <<< "${output}" | cut -d' ' -f2-)"

  # when lb has no nodes, network_vif_id does not exist.
          set +e
    target_vifs="$(egrep ":network_vif_id:"  <<< "${output}" | awk '{print $3}' | tr '\n', ',')"
          set -e

  eval "$(${BASH_SOURCE[0]%/*}/load_balancer-get-ipaddr.sh ${uuid})"
  printf "${fmt}" "${uuid}" "${created_at}" "${status}" "${state}" "${ipaddr_public}" "${ipaddr_managed}" "${ports%%,}" "${protocols%%,}" "\"${display_name}\"" "${target_vifs%%,}"
done
