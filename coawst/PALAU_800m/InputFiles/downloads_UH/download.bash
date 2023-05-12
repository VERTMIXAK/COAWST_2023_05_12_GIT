#!/bin/bash

source ~/.runROMSintel
\rm *.nc

startDay=`date --date="2022-01-25" "+%Y-%m-%d"`
nDaysMinus1=10

for ii in `seq -w 0 $nDaysMinus1`
#for ii in `seq 0 1`
do	
	date=`date --date="$startDay + $ii days" "+%Y-%m-%d" ` 
	outFile="source$ii.nc"
	echo $date $outFile
	part1='http://pae-paha.pacioos.hawaii.edu/thredds/ncss/pacioos/roms_native/mari/ROMS_CNMI_Regional_Ocean_Model_Native_Grid_best.ncd?'
	part2='var=ubar&var=vbar&var=zeta&var=salt&var=temp&var=u&var=v&'
	part3='north=17&west=141&east=148&south=11&disableProjSubset=on&horizStride=1&time_start='
	part4=$date'T00%3A00%3A00Z&time_end='
	part5=$date'T21%3A00%3A00Z&timeStride=1&vertCoord=&addLatLon=true'

	echo "$part1$part2$part3$part4$part5" > url.txt
	wget -O $outFile -i url.txt

	ncks --mk_rec_dmn time -O $outFile $outFile
done






ncrcat source* UH.nc
\rm source*.nc

bash fixUHfields.bash

bash fixUHdimensions.bash

module purge
module load matlab/R2013a
matlab -nodisplay -nosplash < fixMask.m


exit



#\cp now.nc now.nc_BAK4

source ~/.runROMSintel

# move file to BC/IC directory

\rm /import/c1/VERTMIX/jgpender/coawst/GUAMBinner_1km/InputFiles/BC_IC_UH/ini/*.nc
\rm /import/c1/VERTMIX/jgpender/coawst/GUAMBinner_1km/InputFiles/BC_IC_UH/*.nc


mv now.nc /import/c1/VERTMIX/jgpender/coawst/GUAMBinner_1km/InputFiles/BC_IC_UH/BCsource.nc
cd /import/c1/VERTMIX/jgpender/coawst/GUAMBinner_1km/InputFiles/BC_IC_UH/ini

ncks -d ocean_time,0 ../BCsource.nc ICsource.nc

# create IC file

source ~/.runPycnal

python make_weight_files.py
python ini.py

# create BC file

cd ..
python make_bdry_file.py


