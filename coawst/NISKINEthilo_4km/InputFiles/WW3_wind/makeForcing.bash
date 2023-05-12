ncks -d time,1070,2100 ~/coawst/GlobalDataFiles/JRA_NISKINE/JRA55DO_1.4_Uwind_2018_NISKINE_negLons.nc -O uwind.nc
ncks -d time,1070,2100 ~/coawst/GlobalDataFiles/JRA_NISKINE/JRA55DO_1.4_Vwind_2018_NISKINE_negLons.nc -O vwind.nc

ncview uwind.nc 

cp uwind.nc ww3_wind.nc
ncks -A vwind.nc -O ww3_wind.nc

