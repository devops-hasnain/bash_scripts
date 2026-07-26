#!/bin/bash

LIMIT=$( df -h | grep '/dev/root' | awk '{print $5}' | sed 's/%//' )
TH=30

TO="hasnain.cloudness@gmail.com"

if [ $LIMIT -ge $TH ]
then
	echo "WARNING - DISk is Running Out - $LIMIT %" | mail -s "DISK SPACE ALERT !" $TO
else
	echo "All is Well - $LIMIT %"
fi
