sourceGrid = '/import/c1/VERTMIX/jgpender/ROMS/Brian/GUAM_2km/dataDir_Bak/GUAM_2022-03-27.nc_0';
latSource = nc_varget(sourceGrid,'lat');
lonSource = nc_varget(sourceGrid,'lon');

localGrid = 'GUAMM_2km.nc';
latLocal = nc_varget(localGrid,'lat_psi');
lonLocal = nc_varget(localGrid,'lon_psi');

size(latSource)
size(latLocal)



fig(1);clf;
pcolor(latSource - latLocal);shading flat;colorbar

fig(2);clf;
pcolor(lonSource - lonLocal);shading flat;colorbar