#!/bin/bash

h=`hostname -s`
i=`nslookup $h | grep -v "#" | grep -i address | awk '{print $NF}'`

hostname -s > /$h.info
nslookup `hostname -s` | grep -v "#" | grep -i address | awk '{print $NF}' >> /$h.info
ip addr sh | grep $i | awk '{print $NF}' | while read line;do ip addr sh $line | grep ether | awk '{print $2}';done >> /$h.info
hostname --fqdn >> /$h.info
echo "
" >> /$h.info
