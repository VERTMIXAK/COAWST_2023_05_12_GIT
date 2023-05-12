source ~/.runPycnal

\rm *.nc

python make_remap_weights_file.py

yesterday=`cat ../../atm_GFS/dates.txt`
echo $yesterday

dum=`grep -n $yesterday /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt`
dayNm1=`echo $dum | cut -d ',' -f4`
line=`echo $dum | cut -d ':' -f1`

#echo $line
nextLine=`echo " $line + 1 " | bc`
#echo $nextLine

dayN=`head -$nextLine /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | tail -1 | cut -d ',' -f4`

echo $dayNm1 $dayN

cp make_ic_template.py make_ic.py
sed -i  "s/XXX/$dayNm1/" make_ic.py



python make_ic.py
mv GL* file1.nc

cp make_ic_template.py make_ic.py
sed -i  "s/XXX/$dayN/" make_ic.py
python make_ic.py
mv GL* file2.nc

module purge    
module load matlab/R2013a    
matlab -nodisplay -nosplash < averageSnapshots.m

\rm -r file?.nc 
