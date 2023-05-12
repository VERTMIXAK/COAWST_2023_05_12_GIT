#!/bin/bash

for file in `ls *nc`
do
	echo $file
	for tt in `seq -w 0 167`
	do	
		oldName=`echo $file | cut -d '.' -f1`
		echo $oldName $oldName"_"$tt".nc"
		ncks -O -d ocean_time,$tt $file $oldName"_"$tt".nc"
	done		
done
