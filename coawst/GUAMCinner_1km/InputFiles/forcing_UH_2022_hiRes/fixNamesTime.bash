pwd#!/bin/bash

source ~/.runROMSintel

names=("Pair" "Qair" "Tair" "rain" "lwrad_down" "swrad" "Uwind" "Vwind" "albedo" "cloud")
times=("pair_time" "qair_time" "tair_time" "rain_time" "lrf_time" "srf_time" "wind_time" "wind_time" "albedo_time" "cloud_time")

for nn in `seq 0 7`
do
    name=${names[$nn]}
    time=${times[$nn]}
	echo ${names[$nn]} ${times[$nn]}

	date=`ncdump -h $name.nc | grep 'time:units' | cut -c 29-39`
    dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
    echo "date $date   dayNumber $dayNumber"

    source ~/.runPycnal
    python settime.py $name.nc $dayNumber time
    python settime.py $name.nc $dayNumber time_run
    source ~/.runROMSintel

    ncrename -O -h -d time,$time                                        $name.nc
    ncrename -O -h -v time,$time                                        $name.nc
	ncatted -O -a units,$time,o,c,"days since 1900-01-01 00:00:00"  	$name.nc
    ncatted -O -a units,time_run,o,c,"days since 1900-01-01 00:00:00"  	$name.nc

	ncatted -O -a coordinates,$name,o,c,"$time lat lon"					$name.nc

	ncks -O -v $time,$name,lat,lon 										$name.nc $name.nc

done

   

ncatted -O -a units,Pair,o,c,"Pa"     				Pair.nc
source ~/.runPycnal    
python rescale.py Pair.nc Pair


for file in `ls *.nc`
do
	echo $file
	mv $file $file"_ORIG"
done
