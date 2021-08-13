#!/bin/bash
src='/var/McAfee/ens/tp/engine/dat'

# Get latest DAT version
datver=`ls /var/McAfee/ens/tp/engine/dat | grep -E '^[0-9]+$'`

# Check if DAT version is over 24 hours old.
if [ "$(( $(date +"%s") - $(stat -c "%Y" $src/$datver) ))" -lt "86400" ]; then
   exit
fi

# Remove avv* files from DAT version directory then remove the directory
for i in `ls -1 $src/$datver`
do 
  rm -f $src/$datver/$i
done

rmdir $src/$datver

# Run McAfee DAT update task
/opt/McAfee/ens/tp/bin/mfetpcli --runtask --index 3

sleep 90

/opt/McAfee/ens/tp/bin/mfetpcli --version > /tmp/McAfee-DAT-version

#mailx -s "DAT File Update on $(hostname)" -r noreply@spawar.navy.mil richard.w.conrad@navy.mil < /tmp/McAfee-DAT-version
