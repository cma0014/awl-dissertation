#!/bin/bash
(/usr/bin/time -f "%e" ssh spec2000@${2} runlocal.sh ${1} ${3} )2>/tmp/${1}.out

