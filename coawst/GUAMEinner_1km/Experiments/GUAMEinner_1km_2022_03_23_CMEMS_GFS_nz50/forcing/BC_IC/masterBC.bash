\rm scheduleForDeletion/*

yesterday=`cat ../atm_GFS/dates.txt`
echo $yesterday

dum=`grep -n $yesterday /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt`
dayNm1=`echo $dum | cut -d ',' -f4`
line=`echo $dum | cut -d ':' -f1`

#echo $line
nextLine=`echo " $line + 1 " | bc`
#echo $nextLine

dayN=`head -$nextLine /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | tail -1 | cut -d ',' -f4`

echo $dayNm1 $dayN



for dd in `seq -w $dayNm1 365`
do
	cp /import/c1/VERTMIX/jgpender/ROMS/CMEMS/GUAM_2022/data_PHY/GLOBAL*_$dd.nc scheduleForDeletion
done

source ~/.runPycnal
python make_bdry.py

source ~/.runROMSintel

ncrcat -O GL* BC.nc
\rm GL* sche*/*
