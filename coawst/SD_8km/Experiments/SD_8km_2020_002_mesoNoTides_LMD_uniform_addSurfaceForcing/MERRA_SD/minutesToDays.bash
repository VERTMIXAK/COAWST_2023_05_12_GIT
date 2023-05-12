for file in `ls MERRA*.nc`
do
	units=`ncdump -h $file | grep 'time:units' |cut -d '"' -f2 | cut -d ' ' -f1`
	timeName=`ncdump -h $file | grep UNLIM | cut -d '=' -f1 | tr -d " \t\r"`
	echo $file '  ' $units  '$'$timeName'$'

	if [[ $units == 'minutes' ]]
	then
		echo "same  "  $file '  ' $units  '$'$timeName'$'
		mv $file dum.nc
		ncap2 -s $timeName'=double('$timeName')' dum.nc $file

		ncatted -O -a units,"$timeName",o,c,'days since 1900-01-01 00:00:00' $file
		source ~/.runPycnal
		python settime.py $file $timeName
		source ~/.runROMSintel
	fi 

done
