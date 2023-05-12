#!/bin/bash
\rm tS*
for tt in `seq -w 10 99`
do	
#	echo $tt
	cp LJ_500* "tStamp_$tt.nc"
done
