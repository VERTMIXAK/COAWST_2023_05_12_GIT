year="2012"

ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_cloud*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_lwrad_down*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_Pair*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_Qair*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_rain*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_swrad*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_Tair*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_Uwind*$year.nc | grep 'time:units'
ncdump -h /import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_Vwind*$year.nc | grep 'time:units'


