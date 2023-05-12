source ~/.runPycnal

for file in `ls /import/c1/VERTMIX/jgpender/ROMS/CMEMS/SD_2020/data_PHY/*.nc`
do
	cp make_ic_file.py dum.py
	echo $file
	dum=`echo $file | rev | cut -d '/' -f1 | rev`
	sed -i "s/XXXX/$dum/" dum.py

	python dum.py

done
