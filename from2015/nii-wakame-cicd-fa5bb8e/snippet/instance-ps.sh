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

instance_ids="${@:-""}"
state="alive"

## ps

fmt='%-10s %-18s %-19s %-12s %-12s %-12s %-12s %s\n'
printf "${fmt}" INSTANCE IMAGE CREATED STATUS STATE IPADDR VIF NAME

if [[ -n "${instance_ids}" ]]; then
  output="${instance_ids}"
else
  output="$(${BASH_SOURCE[0]%/*}/instance-ls.sh "${state}")"
fi

for uuid in ${output}; do
        output="$(${BASH_SOURCE[0]%/*}/instance-inspect.sh ${uuid})"
        status="$(egrep "^:status:"       <<< "${output}" | awk '{print $2}')"
         state="$(egrep "^:state:"        <<< "${output}" | awk '{print $2}')"
    created_at="$(egrep "^:created_at:"   <<< "${output}" | cut -d' ' -f2-3)"; created_at="${created_at/ /T}"; created_at="${created_at%%.*}"
      image_id="$(egrep "^:image_id:"     <<< "${output}" | awk '{print $2}')"
  display_name="$(egrep "^:display_name:" <<< "${output}" | cut -d' ' -f2-)"
          vifs="$(egrep  ":vif_id:"       <<< "${output}" | awk '{print $3}')"
  eval "$(${BASH_SOURCE[0]%/*}/instance-get-ipaddr.sh ${uuid})"
  printf "${fmt}" "${uuid}" "${image_id}" "${created_at}" "${status}" "${state}" "${ipaddr}" "${vifs}" "\"${display_name}\""
done
