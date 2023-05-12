#!/bin/bash

source ~/.runPycnal
year=2018

#python regrid_runoff.py NG_100m -z --regional_domain -f /import/AKWATERS/kshedstrom/JRA55-flooded/runoff_JRA55-do-1-4-0_${year}.nc NG_runoff_${year}.nc > log

python add_rivers.py JRA-1.4_NG_rivers_${year}.nc
python make_river_clim.py NG_runoff_${year}.nc JRA-1.4_NG_rivers_${year}.nc
## Squeezing JRA is dangerous - different number of rivers when you change years.
##python squeeze_rivers.py JRA-1.4_NG_rivers_${year}.nc squeeze.nc
##mv squeeze.nc JRA-1.4_NG_rivers_${year}.nc
echo "start temp"
python add_temp.py JRA-1.4_NG_rivers_${year}.nc
echo "end temp"
python set_vshape.py JRA-1.4_NG_rivers_${year}.nc

