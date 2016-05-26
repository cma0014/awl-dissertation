#!/bin/bash
cd $1
(head -n 2 $1.iostat.log ; grep cmdk0 $1.iostat.log) > $1.iostat.cmdk0
cd ..
