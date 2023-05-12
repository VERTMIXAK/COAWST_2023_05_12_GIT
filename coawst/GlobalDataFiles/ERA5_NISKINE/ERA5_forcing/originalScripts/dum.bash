#!/bin/bash

source ~/.runPycnal

newDir=ROMSforcing

#\rm $newDir/*

oldDir=site2


newFile=ERA5_2018_rain.nc

ncks -v tp $oldDir/*.nc $newDir/$newFile
ncap2 -O -s 'time=double(time)' $newDir/$newFile $newDir/$newFile
python settime.py $newDir/$newFile
ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newDir/$newFile
ncrename -O -h -d time,rain_time $newDir/$newFile
ncrename -O -h -v time,rain_time $newDir/$newFile
ncrename -O -h -d latitude,lat $newDir/$newFile
ncrename -O -h -d longitude,lon $newDir/$newFile
ncrename -O -h -v latitude,lat $newDir/$newFile
ncrename -O -h -v longitude,lon $newDir/$newFile
ncrename -O -h -v tp,rain $newDir/$newFile
ncatted -O -a units,rain,o,c,"kg m-2 s-1" $newDir/$newFile
python convertRain.py $newDir/$newFile

