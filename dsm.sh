#!/bin/bash

## This while loop was added primarily for the ACAS servers because /var
## sometimes exceeds 90% and then falls back to acceptable levels within the hour
## likely due to scans being performed.
x=1

while [ $x -le 3 ]
do
  if [[ $(df -Ph | grep -v Filesystem | sed s/%//g | awk '{ if($5 > 90) print $0;}') ]]; then
    sleep 600
  fi
  x=$(( $x + 1 ))
done

if [[ $(df -Ph | grep -v Filesystem | sed s/%//g | awk '{ if($5 > 90) print $0;}') ]]; then
  df -Ph | grep -v Filesystem | sed s/%//g | awk '{ if($5 > 90) print $0;}' | awk '{printf $5"\t"$6"\n"}' | mail -s "Disk Space Alert On $(hostname)" -r noreply@<site>.mil -c <user>@navy.mil <user>@mail.mil
fi
