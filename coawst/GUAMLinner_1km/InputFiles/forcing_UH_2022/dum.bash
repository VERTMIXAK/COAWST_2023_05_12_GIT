#!/bin/bash
source ~/.runROMSintel

\rm *.nc originals/*.nc

timeStart="2022-03-12"
echo $timeStart
timeEnd="2022-04-17"
echo $timeEnd

part1='http://pae-paha.pacioos.hawaii.edu/thredds/ncss/wrf_cnmi/WRF_CNMI_Regional_Atmospheric_Model_best.ncd?var='

part2='&north=17&west=140&east=148&south=11&disableProjSubset=on&horizStride=1&time_start='

part3='T00%3A00%3A00Z&time_end='

part4='T00%3A00%3A00Z&timeStride=1&addLatLon=true'

myVar='Pair'
timeVar='pair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='Tair'
timeVar='tair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='Qair'
timeVar='qair_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='Uwind'
timeVar='wind_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='Vwind'
timeVar='wind_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='lwrad_down'
timeVar='lrf_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='rain'
timeVar='rain_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt

myVar='swrad'
timeVar='srf_time'
echo "$part1$myVar$part2$timeStart$part3$timeEnd$part4" > url.txt
wget -O $myVar.nc -i url.txt



mv *.nc originals


# create new netcdf containers for the data and fill them in

module purge
module load matlab/R2013a
matlab -nodisplay -nosplash < createFile.m


# use python to fix the times

/bin/bash fixTime.bash


