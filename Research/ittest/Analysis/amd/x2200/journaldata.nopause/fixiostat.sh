#!/bin/bash
(head -n 2 $1.iostat.log ; grep sd0 $1.iostat.log) > $1.iostat.sd0
