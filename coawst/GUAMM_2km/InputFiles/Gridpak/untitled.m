% sourceGrid = '/import/c1/VERTMIX/jgpender/ROMS/Brian/GUAM_2km/GUAM_grid.nc';
sourceGrid = '/import/c1/VERTMIX/jgpender/ROMS/Brian/GUAM_2km/dataDir/GUAM_2022-03-27.nc_0';


latSource = nc_varget(sourceGrid,'lat');
lonSource = nc_varget(sourceGrid,'lon');

size(lonSource)
size(latSource)
