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

image_ids="${@:-""}"
state="available"

## ps

fmt='%-19s %-19s %-9s %-6s %-4s %s\n'
printf "${fmt}" IMAGE CREATED STATE ARCH TYPE NAME

if [[ -n "${image_ids}" ]]; then
  output="${image_ids}"
else
  output="$(${BASH_SOURCE[0]%/*}/image-ls.sh "${state}")"
fi

for uuid in ${output}; do
        output="$(${BASH_SOURCE[0]%/*}/image-inspect.sh ${uuid})"
         state="$(egrep "^:state:"           <<< "${output}" | awk '{print $2}')"
    created_at="$(egrep "^:created_at:"      <<< "${output}" | cut -d' ' -f2-3)"; created_at="${created_at/ /T}"; created_at="${created_at%%.*}"
          arch="$(egrep  ":arch:"            <<< "${output}" | awk '{print $2}')"
          type="$(egrep  ":service_type:"    <<< "${output}" | awk '{print $2}')"
  display_name="$(egrep "^:display_name:"    <<< "${output}" | cut -d' ' -f2-)"

  printf "${fmt}" "${uuid}" "${created_at}" "${state}" "${arch}" "${type}" "\"${display_name}\""
done
