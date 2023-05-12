sourceDir="/import/c1/VERTMIX/jgpender/ROMS/CMEMS/SD_2020/data_PHY/"
echo $sourceDir

for file in `ls $sourceDir| head -90`
do
#	echo $file
#	ls -l $sourceDir$file
	ncks -O -d X,41,74 -d Y,11,32 $sourceDir$file $file

done

