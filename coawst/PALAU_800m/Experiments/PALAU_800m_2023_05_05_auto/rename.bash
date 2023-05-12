#!/bin/bash

cd netcdfOutput

echo ""


count=0
myString="                "  
for file in `ls *his_*.nc`
do
    count=`echo "$count + 1" | bc`
    echo $count $file
    oldName=`echo $file | rev | cut -d '/' -f1 | rev`
    echo $oldName
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

    newName=$firstPart"_"$myDate'.nc'
    echo $myString$newName
    mv $oldName $newName

    if [ $count -gt 5 ]
    then
        myString="print this one: "
    	cp -f $newName ../../AccumulatedData_PALAU_800m_2022/netcdfOutput
    fi

done



echo ""

count=0
myString="                "
for file in `ls *his2_*.nc`
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

    newName=$firstPart"_"$myDate'.nc'
    echo $myString$newName
    mv $oldName $newName

    if [ $count -gt 5 ]
    then
        myString="print this one: "
        cp -f $newName ../../AccumulatedData_PALAU_800m_2022/netcdfOutput
    fi

done

