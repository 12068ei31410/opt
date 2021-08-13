#!/bin/bash

datestamp=`date +%Y-%m-%d`

for i in `awk -F: '$1 !~ /^root$/ && $2 !~ /^[!*]/ {print $1 ":" $2}' /etc/shadow | cut -d":" -f1`
do 
  chage -d ${datestamp} $i
  echo $i ${datestamp}
  chage -l $i
done
