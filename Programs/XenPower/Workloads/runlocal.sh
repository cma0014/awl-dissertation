#!/bin/bash
/usr/bin/time -f %e runspec --noreportable -c linux-x86-gcc -I $2 2>/tmp/${1}.out
