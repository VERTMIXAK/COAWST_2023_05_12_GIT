source ~/.runPycnal

for file in `ls *.nc`
do
	echo $file
	ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     $file
	python settime.py $file
done
