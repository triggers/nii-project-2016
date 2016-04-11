#!/bin/bash

export CODEDIR="$(cd "$(dirname "$0")" && pwd -P)"

if [ "$*" = "" ]; then
    cd "$CODEDIR/.."
    flist=( notebooks/*.ipynb )
else
    flist=( "$@" )
fi


process1()
{
    while IFS= read -r ln; do
	printf "%s\n" "$ln"
    done
}


for f in "${flist[@]}"; do
    full="$(readlink -f "$f")"
    fdir="$(dirname "$full")"
    fname="${full##*/}"
    mkdir -p "$fdir/expanded"
    process1 <"$f" >"$fdir/expanded/$fname"
done
