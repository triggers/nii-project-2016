#!/bin/bash
 
for job in $(dirname $0)/tiny_web* ; do
    bash $(dirname $0)/${job}/load.sh
done
