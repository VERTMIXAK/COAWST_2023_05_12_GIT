#scp jgpender@perigee.ocean.washington.edu:/data1/parker/LiveOcean_data/grids/cas6/grid.nc .
#scp jgpender@perigee.ocean.washington.edu:/data1/parker/LiveOcean_roms/output/cas6_v3_lo8b/f2020.06.20/* .


scp jgpender@perigee.ocean.washington.edu:/data2/jgpender/HIS/*.nc .

# fix the time stamps

for file in `ls *.nc`
do
	ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" $file
done

source ~/.runPycnal
for file in `ls HIS*`
do
	python settime.py $file
done
