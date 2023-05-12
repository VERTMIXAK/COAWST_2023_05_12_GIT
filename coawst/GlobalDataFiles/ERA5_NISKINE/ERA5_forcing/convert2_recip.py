#!/bin/bash

source ~/.runPycnal

newDir=ROMSforcing

#\rm $newDir/*

oldDir=site2



newFile=ERA5_2018_albedo_recip.nc

ncks -v msnswrfcs $oldDir/*.nc $newDir/$newFile
ncap2 -O -s 'time=double(time)' $newDir/$newFile $newDir/$newFile
python settime.py $newDir/$newFile
ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newDir/$newFile
ncrename -O -h -d time,albedo_time $newDir/$newFile
ncrename -O -h -v time,albedo_time $newDir/$newFile
ncrename -O -h -d latitude,lat $newDir/$newFile
ncrename -O -h -d longitude,lon $newDir/$newFile
ncrename -O -h -v latitude,lat $newDir/$newFile
ncrename -O -h -v longitude,lon $newDir/$newFile
ncrename -O -h -v msnswrfcs,albedo $newDir/$newFile
ncatted -O -a units,albedo,o,c,"1" $newDir/$newFile
python convertAlbedo_recip.py $oldDir/*.nc $newDir/$newFile

