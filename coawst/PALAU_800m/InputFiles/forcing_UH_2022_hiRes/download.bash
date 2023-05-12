#!/bin/bash

source ~/.runROMSintel


\rm *.nc

#timeStart=`date "+%Y-%m-%d"`
#echo $timeStart
#timeEnd=`date --date="$timeStart +4 day" "+%Y-%m-%d"`
#echo $timeEnd

timeStart="2021-11-20"
echo $timeStart
timeEnd="2022-02-02"
echo $timeEnd



part1='http://pae-paha.pacioos.hawaii.edu/thredds/ncss/wrf_guam/WRF_Guam_Regional_Atmospheric_Model_best.ncd?var='

part2='&disableLLSubset=on&disableProjSubset=on&horizStride=1&time_start='

part3='T00%3A00%3A00Z&time_end='

part4='T00%3A00%3A00Z&timeStride=1&addLatLon=true'


myVar='Pair'
timeVar='pair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                     	$myVar.nc
#ncrename -O -h -v time,$timeVar                                    		$myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"     	$myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O 										$myVar.nc $myVar.nc








myVar='Tair'
timeVar='tair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc









myVar='Qair'
timeVar='qair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc








myVar='Uwind'
timeVar='wind_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc









myVar='Vwind'
timeVar='wind_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc









myVar='lwrad_down'
timeVar='lrf_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc







myVar='rain'
timeVar='rain_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc







myVar='swrad'
timeVar='srf_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

#date=`ncdump -h $myVar.nc | grep 'time:units' | cut -c 29-39`
#dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#echo "date $date   dayNumber $dayNumber"
#source ~/.runPycnal
#python settime.py $myVar.nc $dayNumber time 
#source ~/.runROMSintel

#ncrename -O -h -d time,$timeVar                                  	$myVar.nc
#ncrename -O -h -v time,$timeVar                                         $myVar.nc
#ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00"       $myVar.nc
#ncks -v $myVar,$timeVar,lat,lon -O                                      $myVar.nc $myVar.nc


exit


date=`ncdump -h Pair.nc | grep 'time_run:units' | cut -c 33-43`
dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
echo "date $date   dayNumber $dayNumber"

source ~/.runPycnal

python settime.py Pair.nc $dayNumber pair_time
python settime.py Tair.nc $dayNumber tair_time
python settime.py Qair.nc $dayNumber qair_time
python settime.py rain.nc $dayNumber rain_time
python settime.py Uwind.nc $dayNumber wind_time
python settime.py Vwind.nc $dayNumber wind_time
python settime.py lwrad_down.nc $dayNumber lrf_time
python settime.py swrad.nc $dayNumber srf_time

