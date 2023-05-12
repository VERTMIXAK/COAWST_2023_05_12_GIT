#!/bin/bash
\rm tS*
for tt in `seq -w 10 99`
do	
#	echo $tt
	cp lake_jersey_bdry_a.nc "tStamp_$tt.nc"
done
