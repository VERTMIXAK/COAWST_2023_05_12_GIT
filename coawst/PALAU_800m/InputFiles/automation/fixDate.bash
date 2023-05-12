ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" 	HIS0.nc
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     HISend_reduce.nc 
ncatted -O -a units,bry_time,o,c,"days since 1900-01-01 00:00:00"     	bry.nc
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"	 	surfaceTSUVZ_reduce.nc

source /import/home/jgpender/.runPycnal
python settime.py HIS0.nc 					ocean_time
python settime.py HISend_reduce.nc   		ocean_time
python settime.py bry.nc 					bry_time
python settime.py surfaceTSUVZ_reduce.nc 	ocean_time
