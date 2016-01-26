#!/bin/bash
#
# Usage:
#  $0 image_id [keyaord]
#
set -e
set -o pipefail
#set -u

## include

## shell params

image_id="${1}"
: "${image_id:?"should not be empty"}"
keyword="${2:-""}"

## show the image

mussel image show "${image_id}" | egrep "${keyword}"
