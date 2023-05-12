source ~/.runPycnal
cp bak/*.nc .

# albedo

file="albedo.nc"
timeVar="albedo_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays


# cloud

file="cloud.nc"
timeVar="cloud_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays


# lwrad_down

file="lwrad_down.nc"
timeVar="lrf_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays


# Pair

file="Pair.nc"
timeVar="pair_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays

# Qair

file="Qair.nc"
timeVar="qair_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays

# rain

file="rain.nc"
timeVar="rain_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays

# swrad

file="swrad.nc"
timeVar="srf_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays

# Tair

file="Tair.nc"
timeVar="tair_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays

# Uwind

file="Uwind.nc"
timeVar="wind_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays


# Vwind

file="Vwind.nc"
timeVar="wind_time"

baseTime=`ncdump -h $file |grep udunits |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
ncatted -O -a units,$timeVar,o,c,"days since 1900-01-01 00:00:00" $file
python settime.py $file $timeVar $baseDays
