source ~/.runROMSintel

dum=`find ../../ -name HC_100m_2022.??.?? | sort | head -1`
echo $dum
cp $dum/forcing/rivers.nc rivers0.nc

nFiles=`find ../../ -name HC_100m_2022.??.?? | sort | wc -l`
echo $nFiles
nFiles=`echo "$nFiles - 1" | bc`
echo $nFiles

\rm mySource.txt
echo "pwd" >> mySource.txt

ii=1
for dir in `find ../../ -name HC_100m_2022.??.?? | sort | tail -$nFiles`
do
	echo $dir
	number=`echo $dir | cut -d '/' -f3 | cut -d '.' -f2-10 `
	echo $number
	echo "ncks -O -d river_time,7 $dir/forcing/rivers.nc rivers$number.nc"  >> mySource.txt
#    ncks -O -d river_time,7 $dir/forcing/rivers.nc rivers$number.nc
done
#ncrcat -O rivers?.nc rivers.nc

echo "ncrcat -O rivers?.nc rivers.nc" >> mySource.txt


echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/Pair.nc Pair.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/Qair.nc Qair.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/Tair.nc Tair.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/Uwind.nc Uwind.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/Vwind.nc Vwind.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/rain.nc rain.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/lwrad_down.nc lwrad_down.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/swrad.nc swrad.nc_ORIG" >> mySource.txt
echo "ncrcat -O ../../HC_100m_2022.??.??/forcing/HC_bdry.nc HC_bdry.nc_ORIG" >> mySource.txt



\rm rivers?.nc

exit












ncrcat -O ../../HC_100m_2022.??.??/forcing/Pair.nc Pair.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/Qair.nc Qair.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/Tair.nc Tair.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/Uwind.nc Uwind.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/Vwind.nc Vwind.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/rain.nc rain.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/lwrad_down.nc lwrad_down.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/swrad.nc swrad.nc_ORIG
ncrcat -O ../../HC_100m_2022.??.??/forcing/HC_bdry.nc HC_bdry.nc_ORIG

    
module purge    
module load matlab/R2013a    
matlab -nodisplay -nosplash < pareTimes.m


