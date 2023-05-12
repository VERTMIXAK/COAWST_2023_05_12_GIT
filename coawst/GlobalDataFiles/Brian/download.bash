#!/bin/bash

source ~/.runPycnal

names=("Pair" "Qair" "Tair" "rain" "lwrad_down" "swrad" "Uwind" "Vwind" )
times=("pair_time" "qair_time" "tair_time" "rain_time" "lrf_time" "srf_time" "wind_time" "wind_time" )

for nn in `seq 0 7`
do
    name=${names[$nn]}
    time=${times[$nn]}

    echo ${names[$nn]} ${times[$nn]}


	part1='https://pae-paha.pacioos.hawaii.edu/thredds/ncss/wrf_guam/WRF_Guam_Regional_Atmospheric_Model_best.ncd?var='
	part2='&disableLLSubset=on&disableProjSubset=on&horizStride=1&time_start=2022-03-01T0%3A00%3A00Z&time_end=2022-04-30T21%3A00%3A00Z&timeStride=1&addLatLon=true'

	wget  $part1$name$part2 -O $name"_2022.nc"

	ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" 	$name"_2022.nc"	$name"_2022.nc"
	ncatted -O -a coordinates,$name,o,c,"lat lon"					$name"_2022.nc"	$name"_2022.nc"

    ncks --mk_rec_dmn time                          $name"_2022.nc"     -o dum.nc;  mv dum.nc $name"_2022.nc"
    python settime_Brian.py                                         $name"_2022.nc"

	ncrename -O -h -d  time,$time									$name"_2022.nc" 
    ncrename -O -h -v  time,$time                                   $name"_2022.nc" 

done
