for file in `ls CMEMS_PHY_2020_???_bdry*`
do
#	echo $file
	ncdump -v ocean_time $file |grep 'ocean_time =' |grep -v UNLIM
done
