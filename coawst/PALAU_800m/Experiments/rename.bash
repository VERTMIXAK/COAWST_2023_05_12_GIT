#!/bin/bash

dir='PALAU_800m_2023_04_26_auto/netcdfOutput'

count=0
myString="                "
for file in `ls $dir/*avg*.nc`
do
	count=`echo "$count + 1" | bc`
    echo $count $file
    oldName=`echo $file | rev | cut -d '/' -f1 | rev`
#    echo $oldName
    firstPart=`echo $oldName | rev | cut -d '_' -f2-5 | rev`
#    echo $firstPart
    dateSec=`ncdump -v ocean_time $file | tail -20 | grep 'ocean_time =' | cut -d ' ' -f4 `
#    echo "original dateSec " $dateSec

	if [[ -z $dateSec ]];
	then
		echo "did not return a date"
	else
		dateSec=`echo "$dateSec - 43200" | bc`
	    myDate=`grep $dateSec ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f1`
#		echo "date " $myDate
        newName=$firstPart"_"$myDate'.nc'
		if [ $count -gt 5 ]
		then
			myString="print this one: "
		fi
        echo $myString$newName
	fi

done

echo ""


count=0
myString="                "  
for file in `ls $dir/*his_*.nc`
do
    count=`echo "$count + 1" | bc`
    echo $count $file
    oldName=`echo $file | rev | cut -d '/' -f1 | rev`
#    echo $oldName
    firstPart=`echo $oldName | rev | cut -d '_' -f2-5 | rev`
#    echo $firstPart
    dateSec=`ncdump -v ocean_time $file | tail -20 | grep 'ocean_time =' | cut -d ',' -f1 | rev | cut -d ' ' -f1 | rev`
#    echo "original dateSec " $dateSec
    myDate=`grep $dateSec ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f1`

    while [ -z $myDate ]
    do
      	dateSec=`echo "$dateSec - 3600" | bc`
#        echo "new dateSec" $dateSec
        myDate=`grep $dateSec ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f1`
    done

    if [ $count -gt 4 ]
    then
        myString="print this one: "
    fi

    newName=$firstPart"_"$myDate'.nc'
    echo $myString$newName
done



echo ""

count=0
myString="                "
for file in `ls $dir/*his2_*.nc`
do
    count=`echo "$count + 1" | bc`
    echo $count $file
    oldName=`echo $file | rev | cut -d '/' -f1 | rev`
#    echo $oldName
    firstPart=`echo $oldName | rev | cut -d '_' -f2-5 | rev`
#    echo $firstPart
    dateSec=`ncdump -v ocean_time $file | tail -20 | grep 'ocean_time =' | cut -d ',' -f1 | rev | cut -d ' ' -f1 | rev`
#    echo "original dateSec " $dateSec
    myDate=`grep $dateSec ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f1`

    while [ -z $myDate ]
    do
      	dateSec=`echo "$dateSec - 3600" | bc`
#        echo "new dateSec" $dateSec
        myDate=`grep $dateSec ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f1`
    done

    if [ $count -gt 4 ]
    then
        myString="print this one: "
    fi

    newName=$firstPart"_"$myDate'.nc'
    echo $myString$newName
done

