#!/bin/bash
#
# This bash script will (run by typing ./slab_cast.sh in terminal, you may need to enable execution privileges)
# (1) download a 72-h wind forecast in the defined domain
# (2) download a 9 day wind history
# (3) Use matlab to force a slab model with the winds 
#
# Output: The grib2 wind files are saved to ./forecast or ./history, the netCDF slab estimates (with wind included) are saved to ./slab. (I recommend ncview http://meteora.ucsd.edu/~pierce/ncview_home_page.html for quickly exploring the contents, watching the movies, etc.)
#
#
# Configuration: 
# (1) You can adjust the length of the history and forecast downloads from this script (then adjust slab_cast.m accordingly)
# (2) You can adjust the slab-model damping by editing slab_cast.m
# (3) You'll need to create a directory "mkdir ./currents/", put today's HYCOM uv file in there, and give slab_cast.m the correct info about the naming convention  
# (4) You may need to setup the nctoolbox at the start of slab_cast.m
#
# Dependencies:
# (1) linux Bash shell interpreter 
# (2) Matlab with the Air-Sea toolbox (https://sea-mat.github.io/sea-mat/) and NCTOOLBOX (http://polar.ncep.noaa.gov/ofs/examples/usingmatlab.shtml#example_2)
#		
# Release notes:
# V2 - removed calls to wgrib2, the matlab program now reads the grib2 files directly
#	 - Now use fprinf to zero pad file numbers, this is more universal than bash syntax {001..0072} 
#
#
# Copyright (c) 3 May 2018, Samuel Kelly (smkelly@d.umn.edu)

########################################################################
# User defined footprint
lon_max=345
lon_min=325

lat_max=64
lat_min=55

# Get today's date (this computer should be in UTC)
now="$(date +'%Y%m%d')" 

# Print date to screen
printf "\nRunning slab forecast for $(date +'%Y-%m-%d') \n"

########################################################################
# Download 72-h GFS forecast from nomads.ncep.noaa.gov

# Make forecast directory if it doesn't exist
if [ ! -d "forecast" ]; then
	mkdir forecast
fi

# Check if the data already exists
if [ ! -f ./forecast/"$now".grib2 ]; then
	# Alert user of download
	printf "Downloading today's wind forecast \n"

	# Make a directory for today
	mkdir tmp

	# Download data (change upper limit of loop for longer/shorter forecasts)
	for hour in {0..72}; do
	
		# Add leading zeros to hour
		hour_padded=$(printf "%03d" $hour)

echo "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25_1hr.pl'?'file'='gfs.t00z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgfs."$now"00"
exit
		
		wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25_1hr.pl'?'file'='gfs.t00z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgfs."$now"00 -O ./tmp/"$hour".grib2 --waitretry=1



	done

	# combine all grib files
	cat ./tmp/{0..72}.grib2 >> ./forecast/"$now".grib2
	
	# Remove grib directory (this will fail if there are non-grib2 files in the directory) 
	rm ./tmp/*.grib2
	rmdir tmp

else
	# Alert user of non-download
	printf "Today's Wind forecast was already downloaded\n"
 	
fi

########################################################################
# Download 9-day GDAS history from nomads.ncep.noaa.gov 
#
# One 24-h file is created for each day, it consists of the 6 hourly now
# casts, filled in by 5 hour forecasts 

# Make history directory if it doesn't exist
if [ ! -d "history" ]; then
	mkdir history
fi

# Cycle through the last 9 days (this is the longest data is available on the server)
for lag in {9..1..-1}; do
	day="$(date +'%Y%m%d' --date="-"$lag" day")" 
	
	# Check if the data already exists
	if [ ! -f ./history/"$day".grib2 ]; then
		
		# Alert user of download
		printf "Downloading the wind history from $(date +'%Y-%m-%d' --date="-"$lag" day") \n"
		
		# Make temporary directory
		mkdir tmp

		# Get 000h data
		for hour in {0..5}; do
		
			# Add leading zeros to hour
			hour_padded=$(printf "%03d" $hour)
			num=$(($hour + 0))

			wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gdas_0p25.pl'?'file'='gdas.t00z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgdas."$day" -O ./tmp/"$num".grib2
		done
		
		# Get 006h data
		for hour in {0..5}; do
			
			# Add leading zeros to hour
			hour_padded=$(printf "%03d" $hour)
			num=$(($hour + 6))
		
			wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gdas_0p25.pl'?'file'='gdas.t06z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgdas."$day" -O ./tmp/"$num".grib2
		done
				
		# Get 012h data
		for hour in {0..5}; do
		
			# Add leading zeros to hour
			hour_padded=$(printf "%03d" $hour)
			num=$(($hour + 12))

			wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gdas_0p25.pl'?'file'='gdas.t12z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgdas."$day" -O ./tmp/"$num".grib2
		done
		
		# Get 018h data
		for hour in {0..5}; do
		
			# Add leading zeros to hour
			hour_padded=$(printf "%03d" $hour)
			num=$(($hour + 18))
		
			wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gdas_0p25.pl'?'file'='gdas.t18z.pgrb2.0p25.f"$hour_padded"'&'lev_10_m_above_ground'='on'&'var_UGRD'='on'&'var_VGRD'='on'&'subregion'=&'leftlon'='"$lon_min"'&'rightlon'='"$lon_max"'&'toplat'='"$lat_max"'&'bottomlat'='"$lat_min"'&'dir'=%'2Fgdas."$day" -O ./tmp/"$num".grib2
		done
		
		# combine all grib files
		cat ./tmp/{0..23}.grib2 >> ./history/"$day".grib2		
		
		# Remove grib directory (this will fail if there are non-grib2 files in the directory) 
		rm ./tmp/*.grib2
		rmdir tmp

	else
		# Alert user of previous download
		printf "Wind history from $(date +'%Y-%m-%d' --date="-"$lag" day") was already downloaded\n"
	fi	
done

########################################################################
# Run the slab model in Matlab 
matlab -nodisplay -nodesktop -r "run ./slab_cast_v2.m; quit;" >/dev/null 

# Clean up the nctoolbox garbage
rm ./forecast/*.ncx ./forecast/*.gbx9
rm ./history/*.ncx ./history/*.gbx9





