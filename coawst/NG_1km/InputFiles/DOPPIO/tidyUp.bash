source ~/.runPycnal

for file in `ls run*.nc`
do
	echo $file
    ncrename -O -h -d time,ocean_time       $file
    ncrename -O -h -v time,ocean_time       $file
	ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" $file
	python settime.py $file

done


exit


module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a

matlab -nodisplay -nosplash < addUV.m

