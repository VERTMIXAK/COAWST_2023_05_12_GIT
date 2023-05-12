cd netcdfOutput
for file in `ls *.nc`
do
	echo $file
	ncatted -O -a src_dir,global,a,c,`pwd` $file
done
cd ..

