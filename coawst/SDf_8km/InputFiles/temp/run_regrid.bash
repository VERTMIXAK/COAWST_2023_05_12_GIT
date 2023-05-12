#!/bin/bash

source ~/.runPycnal

year=2018

python regrid_runoff.py SDf_8km -z --regional_domain -f /import/c1/AKWATERS/kate/JRA55-do/runoff_JRA55-do-1-4-0_${year}.* MCKR_runoff_${year}.nc > log


python add_rivers.py JRA-1.4_MCKR_rivers_${year}.nc
python make_river_clim.py MCKR_runoff_${year}.nc JRA-1.4_MCKR_rivers_${year}.nc
## Squeezing JRA is dangerous - different number of rivers when you change years.
##python squeeze_rivers.py JRA-1.4_MCKR_rivers_${year}.nc squeeze.nc
##mv squeeze.nc JRA-1.4_MCKR_rivers_${year}.nc


python add_temp_3D.py JRA-1.4_MCKR_rivers_${year}.nc


python set_vshape.py JRA-1.4_MCKR_rivers_${year}.nc

