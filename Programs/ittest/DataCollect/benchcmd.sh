#!/bin/bash
SPECLOC=$HOME/Research/cpu2006
pushd $SPECLOC
source shrc
runspec --config powermodel.cfg --noreportable $1
popd
