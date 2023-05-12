
cp Tair.nc Tair_Kelvin.nc

ncatted -O -a units,Tair,o,c,"C" 	Tair.nc
ncatted -O -a valid_range,Tair,d,, 		Tair.nc


source ~/.runPycnal
python Kelvin2Celsius.py Tair.nc
