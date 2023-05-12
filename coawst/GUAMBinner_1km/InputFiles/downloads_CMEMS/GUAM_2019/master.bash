#!/bin/bash
\rm -r data_*

# First load the desired dates to file

grep `date --date=yesterday "+%Y-%m-%d"` /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | tail -1 >  dates.txt
grep `date                  "+%Y-%m-%d"` /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | tail -1 >> dates.txt
grep `date --date=tomorrow  "+%Y-%m-%d"` /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | tail -1 >> dates.txt









echo " "
echo "Here are the lat/lon settings:"
echo " "
cat latlon.txt
echo " "

read -r -p "Is this what you want? [y/n] " latLonCheck

case $latLonCheck in
   [nN][oO]|[nN])
echo 'redo lat/lon'
exit 1
     ;;
esac

echo "latLon.txt is presumed OK."

bash makeMotu_PHY.bash
bash motu.bash

bash fixTimeAndFields.bash

module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < expandLatLon.m



bash makeMotu_WAV.bash
bash motu.bash

bash makeMotu_SL.bash
bash motu.bash

