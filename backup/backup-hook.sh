#!/bin/bash
now=`date +%s` # secs since unix epoch
lastBackup=0
if [ ! -e '/home/sudokraft/.sudokraft-last-backup' ]
then
   echo 'Last backup time not found. Running initial backup'
else
   lastBackup=`cat /home/sudokraft/.sudokraft-last-backup `
fi

diff=`echo "$now - $lastBackup" | bc `

diffInHours=`echo "$diff / 60 / 60" | bc `
if [ "$diffInHours" -ge "24" ]
then
   echo -n $now > '/home/sudokraft/.sudokraft-last-backup'
   exec /home/sudokraft/shabam/shabam $@
fi
