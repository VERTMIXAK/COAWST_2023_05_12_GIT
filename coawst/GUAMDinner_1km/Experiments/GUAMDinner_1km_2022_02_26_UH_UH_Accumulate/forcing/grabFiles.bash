ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/Pair.nc Pair.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/Qair.nc Qair.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/Tair.nc Tair.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/Uwind.nc Uwind.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/Vwind.nc Vwind.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/rain.nc rain.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/lwrad_down.nc lwrad_down.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/swrad.nc swrad.nc_ORIG
ncrcat -O ../../GUAMDinner_1km_2022_??_??_UH_UH/forcing/UH_2022_bdry_GUAMDinner_1km.nc UH_2022_bdry_GUAMDinner_1km.nc_ORIG

  
module purge    
module load matlab/R2013a    
matlab -nodisplay -nosplash < pareTimes.m



