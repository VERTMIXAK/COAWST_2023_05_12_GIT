scp jgpender@perigee.ocean.washington.edu:/home/jgpender/data/addDay/rivers.nc riversLO.nc


ncatted -O -a units,river_time,o,c,"days since 1900-01-01 00:00:00" riversLO.nc

source ~/.runPycnal
python settime.py riversLO.nc
