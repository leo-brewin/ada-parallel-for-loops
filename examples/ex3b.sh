#!/bin/bash

PROGRAM=$(basename $0 ".sh")

build.sh $PROGRAM || exit

if [[ -e bin/$PROGRAM ]]; then
   bin/$PROGRAM $*
fi
