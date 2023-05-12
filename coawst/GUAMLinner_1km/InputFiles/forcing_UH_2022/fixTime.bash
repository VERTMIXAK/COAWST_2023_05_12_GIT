#!/bin/bash
source ~/.runPycnal

# The original time stamps are in terms of
# "hours since 2013-06-14 00:00:00.000 UTC"
#
# Change to days since 1900 using
#
#	2013-06-14,41437,4913,165,3580156800,1371200400,

#for file in `ls originals/*.nc`
#do
#	cp $file .	
#done


names=("Pair" "Qair" "Tair" "rain" "lwrad_down" "swrad" "Uwind" "Vwind" "albedo" "cloud")
times=("pair_time" "qair_time" "tair_time" "rain_time" "lrf_time" "srf_time" "wind_time" "wind_time" "albedo_time" "cloud_time")




for nn in `seq 0 7`
do
    name=${names[$nn]}
    time=${times[$nn]}
    echo ${names[$nn]} ${times[$nn]}

#    ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00"		$name.nc
#    ncatted -O -a units,time_run,o,c,"days since 1900-01-01 00:00:00"   $name.nc
#	ncks --mk_rec_dmn time -O 											$name.nc $name.nc

	python settime.py 	$name.nc  $time 41437

##	ncrename -O -h -d time,$time $name.nc
##	ncrename -O -h -v time,$time $name.nc

done




exit


for file in `ls *.nc`
do
    echo $file
    ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" 		$file
    ncatted -O -a units,time_run,o,c,"days since 1900-01-01 00:00:00" 	$file

    python settime.py $file
done



ncrename -O -h -d time,pair_time Pair.nc
ncrename -O -h -v time,pair_time Pair.nc

ncrename -O -h -d time,qair_time Qair.nc
ncrename -O -h -v time,qair_time Qair.nc

ncrename -O -h -d time,tair_time Tair.nc
ncrename -O -h -v time,tair_time Tair.nc

ncrename -O -h -d time,rain_time rain.nc 
ncrename -O -h -v time,rain_time rain.nc 

ncrename -O -h -d time,lrf_time lwrad_down.nc
ncrename -O -h -v time,lrf_time lwrad_down.nc

ncrename -O -h -d time,srf_time swrad.nc
ncrename -O -h -v time,srf_time swrad.nc

ncrename -O -h -d time,wind_time Uwind.nc
ncrename -O -h -v time,wind_time Uwind.nc

ncrename -O -h -d time,wind_time Vwind.nc
ncrename -O -h -v time,wind_time Vwind.nc
