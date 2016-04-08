#!/bin/bash
[[ -f $(dirname $0)/stepdata.conf ]] && . $(dirname $0)/stepdata.conf
[[ -f $(dirname $0)/pre-exec.sh ]] && . $(dirname $0)/pre-exec.sh

bash
