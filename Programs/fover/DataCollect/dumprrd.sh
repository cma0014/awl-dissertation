#! /bin/bash
echo -n $2,$3
rrdtool fetch $1/$2/$3 AVERAGE -s $4 -e $5 | grep ':' | grep -v 'nan'| cut -f 2 -d: | perl ~/Public/average.pl
