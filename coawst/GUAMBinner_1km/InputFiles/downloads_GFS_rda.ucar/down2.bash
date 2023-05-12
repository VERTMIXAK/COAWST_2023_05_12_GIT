#!/bin/bash

\rm *.nc url*.txt *.tmp

now=`date -d "-1 days" "+%Y%m%d"`
nowM1=`date -d "-2 days" "+%Y%m%d"`
echo $now

window=24
hours=( $(seq -w 0 3 $window))
nSnapshots=${#hours[@]}
echo "nSnapshots = $nSnapshots"



####### albedo   WARNING !!! 6-hour ave means take only every other point,
##############  DO SOMETHING ABOUT ENDPOINTS

	myHour=24
    outFile=out_000.nc
    urlFile=url_.txt

    part1="https://rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/2022/"

    part2="$nowM1/gfs.0p25."

    part3=$nowM1"00.f0"

    part4="$myHour.grib2?var=Albedo_surface_6_Hour_Average&north=17&west=141&east=148&south=11&horizStride=1&time_start="

    datePlus=`date -d "$nowM1 + $myHour hours" "+%Y-%m-%dT%H:%M:%S"`

    part5=$datePlus"Z&time_end="

    part6=$datePlus"Z&timeStride=1&vertCoord=&accept=netcdf3&addLatLon=true"

    echo $part1$part2$part3$part4$part5$part6 > $urlFile
    wget -O $outFile -i $urlFile

    timeVar=`ncdump -h $outFile | grep time | head -1 |   tr -d '\t' | cut -d ' ' -f1`

    boundsVar=`ncdump -h $outFile | grep bounds | grep double | cut -d '(' -f1 | rev | cut -d ' ' -f1 | rev`
    echo $boundsVar
    echo ""

    ncrename -O -h -d $timeVar,albedo_time    $outFile
    ncrename -O -h -v $timeVar,albedo_time    $outFile
    ncks    --mk_rec_dmn albedo_time -O    $outFile $outFile
    ncrename -O -h -v   Albedo_surface_6_Hour_Average,albedo $outFile
    ncrename -O -h -v   $boundsVar,time_bounds $outFile




for ((ii=2;ii<$nSnapshots;ii+=2));
do
#   echo $ii  ${hours[$ii]}
    outFile=out_${hours[$ii]}.nc
    urlFile=url_${hours[$ii]}.txt
#   echo $outFile

    part1="https://rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/2022/"
#   echo "part1:    $part1"

    part2="$now/gfs.0p25."
#   echo "part2:    $part2"

    part3=$now"00.f0"
#    echo "part3:    $part3"

    part4="${hours[$ii]}.grib2?var=Albedo_surface_6_Hour_Average&north=17&west=141&east=148&south=11&horizStride=1&time_start="
#   echo "part4:    $part4"

    datePlus=`date -d "$now + ${hours[$ii]} hours" "+%Y-%m-%dT%H:%M:%S"`
#   echo $datePlus

    part5=$datePlus"Z&time_end="
#   echo "part5:    $part5"

    part6=$datePlus"Z&timeStride=1&vertCoord=&accept=netcdf3&addLatLon=true"
#    echo "part6:    $part6"

    echo $part1$part2$part3$part4$part5$part6 > $urlFile
    wget -O $outFile -i $urlFile

    timeVar=`ncdump -h $outFile | grep time | head -1 |   tr -d '\t' | cut -d ' ' -f1`
   echo ""
   echo $timeVar
   echo ""

    boundsVar=`ncdump -h $outFile | grep bounds | grep double | cut -d '(' -f1 | rev | cut -d ' ' -f1 | rev`
    echo $boundsVar
    echo ""

    ncrename -O -h -d $timeVar,albedo_time    $outFile
    ncrename -O -h -v $timeVar,albedo_time    $outFile
    ncks    --mk_rec_dmn albedo_time -O	   $outFile $outFile
    ncrename -O -h -v   Albedo_surface_6_Hour_Average,albedo $outFile
    ncrename -O -h -v   $boundsVar,time_bounds $outFile
done

exit

ncrcat out*.nc albedo.nc
\rm out*.nc url*.txt


