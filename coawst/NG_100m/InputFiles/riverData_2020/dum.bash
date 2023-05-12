file="temp_Taunton"
\rm $file"_dailyAve.txt"
for month in `seq -w 1 10`
do
    echo $month

    grep 2020-$month $file.txt | cut -d ',' -f5 > dum.txt

    sum=`awk '{s+=$1} END {print s}' dum.txt`
#   echo "sum $sum"
    n=`wc -l dum.txt | cut -d " " -f1`
#   echo "n $n"
    ave=` echo "scale=2; $sum / $n " | bc`
#   echo $ave
    echo $month $ave >> $file"_monthlyAve.txt"
done

