#sed 's/\t/,/g' data_ORIG/flow_Blackstone.txt >flow_Blackstone.txt
#sed 's/\t/,/g' data_ORIG/flow_Pawtuxet.txt >flow_Pawtuxet.txt
#sed 's/\t/,/g' data_ORIG/flow_Taunton.txt >flow_Taunton.txt
#sed 's/\t/,/g' data_ORIG/temp_Taunton.txt >temp_Taunton.txt


# the temperature file only goes up to day 279, which is good enough for now.

N=275


file="flow_Blackstone"
\rm $file"_dailyAve.txt"
for day in `seq -w 1 $N`
do
    echo $day
    date=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f1 | cut -c 6-10`
	dayN=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f2`".5"

    grep $date $file.txt | cut -d ',' -f5 > dum.txt

    sum=`awk '{s+=$1} END {print s}' dum.txt`
#   echo "sum $sum"
    n=`wc -l dum.txt | cut -d " " -f1`
#   echo "n $n"
	# don't forget to convert ft^3 to kg
    ave=` echo "scale=2; $sum / $n * 1000. / 35.315 " | bc`
#   echo $ave
#	echo $file_dailyAve.txt

    echo $dayN $ave >> $file"_dailyAve.txt"
done



file="flow_Pawtuxet"
\rm $file"_dailyAve.txt"
for day in `seq -w 1 $N`
do
    echo $day
    date=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f1 | cut -c 6-10`
    dayN=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f2`".5"

    grep $date $file.txt | cut -d ',' -f5 > dum.txt

    sum=`awk '{s+=$1} END {print s}' dum.txt`
#   echo "sum $sum"
    n=`wc -l dum.txt | cut -d " " -f1`
#   echo "n $n"
    # don't forget to convert ft^3 to m^3  
    ave=` echo "scale=2; $sum / $n * 1000. / 35.315 " | bc`

#   echo $ave
    echo $dayN $ave >> $file"_dailyAve.txt"
done


file="flow_Taunton"
\rm $file"_dailyAve.txt"
for day in `seq -w 1 $N`
do
    echo $day
    date=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f1 | cut -c 6-10`
    dayN=`grep 2020- ~/addl_Scripts/dayConverterCommas.txt | grep ','$day',' | cut -d ',' -f2`".5"

    grep $date $file.txt | cut -d ',' -f5 > dum.txt

    sum=`awk '{s+=$1} END {print s}' dum.txt`
#   echo "sum $sum"
    n=`wc -l dum.txt | cut -d " " -f1`
#   echo "n $n"
    # don't forget to convert ft^3 to m^3  
    ave=` echo "scale=2; $sum / $n * 1000. / 35.315 " | bc`
#   echo $ave
    echo $dayN $ave >> $file"_dailyAve.txt"
done


file="temp_Taunton"
\rm $file"_dailyAve.txt"
for month in `seq -w 1 12`
do
    echo $month

    grep 2020-$month $file.txt | cut -d ',' -f5 > dum.txt

    sum=`awk '{s+=$1} END {print s}' dum.txt`
#   echo "sum $sum"
    n=`wc -l dum.txt | cut -d " " -f1`
#   echo "n $n"
    ave=` echo "scale=1; $sum / $n " | bc`
#   echo $ave
    echo $month $ave >> $file"_monthlyAve.txt"
done

