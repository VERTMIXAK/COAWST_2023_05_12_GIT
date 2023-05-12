myHome=`pwd`
echo $myHome

for dir in `ls |grep netcdfOutput_days`
do

	echo "$myHome/$dir"
	cd "$myHome/$dir"
	pwd

	for file in `ls | grep _his2_`
	do
		nTimes=`ncdump -h $file | grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
		echo $nTimes

		if [ $nTimes -eq 25 ];
		then
			ncks -O -d ocean_time,0,24,3 $file $file
		else
			ncks -O -d ocean_time,2,23,3 $file $file
		fi
	done



    for file in `ls | grep _his_`
    do
      	echo $file

      	nTimes=`ncdump -h $file | grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
        echo $nTimes

        if [ $nTimes -eq 9 ];
        then
            ncks -O -d ocean_time,0,8,2 -x -v zeta,ubar,vbar $file $file
        else
            ncks -O -d ocean_time,1,7,2 -x -v zeta,ubar,vbar $file $file
        fi
    done


	cd ..
done
