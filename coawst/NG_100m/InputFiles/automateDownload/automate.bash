
part1='https://nwis.waterservices.usgs.gov/nwis/iv/?sites='
part2='&parameterCd=00060&startDT='
part3='T23:00:00.000-04:00&endDT='
part4='T02:00:00.000-04:00&siteStatus=all&format=rdb'


loc='01108000'

for line in `cat dates.txt`
do
	date=`echo $line | cut -d ',' -f1`
	date1=`date "+%Y-%m-%d" -d "$date-1 days"`
    date2=`date "+%Y-%m-%d" -d "$date+1 days"`

	url=$part1$loc$part2$date1$part3$date2$part4
	echo $url
	wget `echo $url` -O out.txt
	grep USGS out.txt | grep -v '#' | grep $date > out_$date.txt
	\rm out.txt
done	
