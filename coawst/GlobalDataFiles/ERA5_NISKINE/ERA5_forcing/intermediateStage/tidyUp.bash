#!/bin/bash



ncatted -O -a coordinates,swrad,o,c,"lon lat" ERA5_2018_swrad.nc
mv dum.nc ERA5_2018_swrad.nc
echo "done with swrad"

ncatted -O -a coordinates,lwrad_down,o,c,"lon lat" ERA5_2018_lwrad_down.nc  dum.nc
mv dum.nc ERA5_2018_lwrad_down.nc
echo "done with lwrad_down"

ncatted -O -a coordinates,Pair,o,c,"lon lat" ERA5_2018_Pair.nc  dum.nc
mv dum.nc ERA5_2018_Pair.nc
echo "done with Pair"

ncatted -O -a coordinates,Tair,o,c,"lon lat" ERA5_2018_Tair.nc  dum.nc
mv dum.nc ERA5_2018_Tair.nc
echo "done with Tair"

ncatted -O -a coordinates,Qair,o,c,"lon lat" ERA5_2018_Qair.nc  dum.nc
mv dum.nc ERA5_2018_Qair.nc
echo "done with Qair"

ncatted -O -a coordinates,rain,o,c,"lon lat" ERA5_2018_rain.nc  dum.nc
mv dum.nc ERA5_2018_rain.nc
echo "done with rain"

ncatted -O -a coordinates,Uwind,o,c,"lon lat" ERA5_2018_Uwind.nc  dum.nc
mv dum.nc ERA5_2018_Uwind.nc
echo "done with Uwind"

ncatted -O -a coordinates,Vwind,o,c,"lon lat" ERA5_2018_Vwind.nc  dum.nc
mv dum.nc ERA5_2018_Vwind.nc
echo "done with Vwind"

ncatted -O -a coordinates,albedo,o,c,"lon lat" ERA5_2018_albedo.nc  dum.nc
mv dum.nc ERA5_2018_albedo.nc
echo "done with albedo"


