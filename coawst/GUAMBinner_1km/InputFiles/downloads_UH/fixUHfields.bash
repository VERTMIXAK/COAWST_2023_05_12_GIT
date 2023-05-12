myFile="now.nc"

date=`ncdump -h now.nc |grep 'time:units' | cut -d ' ' -f5`

dayNumber=`grep $date ~/arch/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
echo "date $date   dayNumber $dayNumber"

ncrename -O -h -d time,ocean_time                                       now.nc
ncrename -O -h -v time,ocean_time                                       now.nc
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     now.nc

ncatted -O -a _FillValue,salt,d,,                                       now.nc
ncatted -O -a _FillValue,temp,d,,                                       now.nc
ncatted -O -a _FillValue,ubar,d,,                                       now.nc
ncatted -O -a _FillValue,vbar,d,,                                       now.nc
ncatted -O -a _FillValue,zeta,d,,                                       now.nc
ncatted -O -a _FillValue,u,d,,                                       	now.nc
ncatted -O -a _FillValue,v,d,,                                       	now.nc



#ncatted -O -a _FillValue,salt,o,c,"1.e+37f"     						now.nc
#ncatted -O -a _FillValue,temp,o,c,"1.e+37f"                             now.nc
#ncatted -O -a _FillValue,u,o,c,"1.e+37f"                             	now.nc
#ncatted -O -a _FillValue,u,o,c,"1.e+37f"                          		now.nc
#ncatted -O -a _FillValue,ubar,o,c,"1.e+37f"                             now.nc
#ncatted -O -a _FillValue,vbar,o,c,"1.e+37f"                             now.nc
#ncatted -O -a _FillValue,zeta,o,c,"1.e+37f"                             now.nc




#nxGrid=`ncdump -h $myFile |grep "X =" |cut -d "=" -f2 | cut -d " " -f2 `
#nyGrid=`ncdump -h $myFile |grep "Y =" |cut -d "=" -f2 | cut -d " " -f2 `
#
#echo "nx, ny =  " $nxGrid  $nyGrid

source ~/.runPycnal
python settime.py $myFile $dayNumber

