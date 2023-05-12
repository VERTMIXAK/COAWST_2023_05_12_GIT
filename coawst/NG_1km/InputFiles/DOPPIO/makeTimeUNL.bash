for oldFile in `ls scheduleForDeletion4/run*.nc`
do
	newFile=`echo $oldFile | cut -d '/' -f2`
	echo $oldFile $newFile
	ncks  --mk_rec_dmn  ocean_time  $oldFile -o $newFile


done
