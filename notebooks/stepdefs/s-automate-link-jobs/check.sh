#!/bin/bash
 
for job in $(dirname $0)/tiny_web* ; do
    bash ${job}/check.sh
done
