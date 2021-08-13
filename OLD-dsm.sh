#!/bin/bash

if [[ $(df -Ph | grep -v Filesystem | sed s/%//g | awk '{ if($5 > 90) print $0;}') ]]; then
  df -Ph | grep -v Filesystem | sed s/%//g | awk '{ if($5 > 90) print $0;}' | awk '{printf $5"\t"$6"\n"}' | mail -s "Disk Space Alert On $(hostname)" -r noreply@<site>.mil -c <user>@navy.mil <user>@mail.mil
fi
