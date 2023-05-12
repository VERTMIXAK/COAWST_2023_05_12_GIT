for file in `ls *.nc`
do
#	echo $file
	ncdump -h $file | grep 'time_run:units'
done

exit
ncdump -h Pair.nc | grep 'time_run:units'
