#!/bin/bash
sed "s/trash/$1/g" <collectstats.sql | psql -d xenpower -U xenpower 
 
