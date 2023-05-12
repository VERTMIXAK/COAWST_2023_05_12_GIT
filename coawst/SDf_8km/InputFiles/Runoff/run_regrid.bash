#!/bin/bash

source ~/.runPycnal

year=2018

#python regrid_runoff.py SDf_8km -z --regional_domain -f ./Kate_JRA/runoff*${year}*.nc SDf_runoff_${year}.nc > log
python regrid_runoff.py SDf_8km -z --regional_domain -f /import/AKWATERS/kshedstrom/JRA55-flooded/runoff*${year}*.nc SDf_runoff_${year}.nc > log

python add_rivers.py JRA-1.4_SDf_rivers_${year}.nc
python make_river_clim.py SDf_runoff_${year}.nc JRA-1.4_SDf_rivers_${year}.nc
## Squeezing JRA is dangerous - different number of rivers when you change years.
##python squeeze_rivers.py JRA-1.4_SDf_rivers_${year}.nc squeeze.nc
##mv squeeze.nc JRA-1.4_SDf_rivers_${year}.nc


python add_temp_3D.py JRA-1.4_SDf_rivers_${year}.nc


python set_vshape.py JRA-1.4_SDf_rivers_${year}.nc

