scp jgpender@perigee.ocean.washington.edu:/data2/jgpender/*.nc .



# change the dimension names

for file in `ls *.nc`
do
	echo $file
	ncrename -d xi_rho,lon -d eta_rho,lat -O $file 
done







# add the coordinates attribute to the main field

ncatted -O -a  coordinates,Pair,o,c,"lon lat"       Pair.nc
ncatted -O -a  coordinates,Tair,o,c,"lon lat"       Tair.nc
ncatted -O -a  coordinates,Qair,o,c,"lon lat"       Qair.nc
ncatted -O -a  coordinates,lwrad_down,o,c,"lon lat" lwrad_down.nc
ncatted -O -a  coordinates,swrad,o,c,"lon lat"      swrad.nc
ncatted -O -a  coordinates,rain,o,c,"lon lat"       rain.nc
ncatted -O -a  coordinates,Uwind,o,c,"lon lat"      Uwind.nc
ncatted -O -a  coordinates,Vwind,o,c,"lon lat"      Vwind.nc




# fix the time stamps

ncatted -O -a units,pair_time,o,c,"days since 1900-01-01 00:00:00" Pair.nc
ncatted -O -a units,qair_time,o,c,"days since 1900-01-01 00:00:00" Qair.nc
ncatted -O -a units,tair_time,o,c,"days since 1900-01-01 00:00:00" Tair.nc
ncatted -O -a units,lrf_time,o,c,"days since 1900-01-01 00:00:00" lwrad_down.nc
ncatted -O -a units,srf_time,o,c,"days since 1900-01-01 00:00:00" swrad.nc
ncatted -O -a units,rain_time,o,c,"days since 1900-01-01 00:00:00" rain.nc
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00" Uwind.nc
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00" Vwind.nc

source ~/.runPycnal
python settime.py Pair.nc       pair_time
python settime.py Qair.nc       qair_time
python settime.py Tair.nc       tair_time
python settime.py lwrad_down.nc lrf_time
python settime.py swrad.nc      srf_time
python settime.py rain.nc       rain_time
python settime.py Uwind.nc      wind_time
python settime.py Vwind.nc      wind_time


