for file in `ls scheduleForDeletion3/run*.nc`
do
	echo $file
	rootNew=`echo $file | cut -d '/' -f2 | cut -d 'T' -f1`
	echo $rootNew

	for ii in `seq -w 0 23`
	do
		ncks -d ocean_time,$ii --mk_rec_dmn  ocean_time  $file $rootNew"_"$ii".nc"
	done

done
