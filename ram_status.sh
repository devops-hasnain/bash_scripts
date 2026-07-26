#!/bin/bash

#Defining threshold (TH) limit warning for available RAM space.

LIMIT=$( free -mt | grep "Total" | awk '{print $4}' )
TH=410

if [ $LIMIT -le $TH ]
then 
	echo "WARNING ! Ram is Low. Current $LIMIT"
else
	echo "RAM is Sufficient. Current $LIMIT"
fi
