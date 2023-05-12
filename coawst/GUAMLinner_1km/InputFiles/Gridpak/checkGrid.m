clear;close;tabwindow;

parentFile = 'GUAMLinner_1km.nc';
subFile    = 'GUAMLinnerNest_1km.nc';

latParent = nc_varget(parentFile,'lat_rho');
lonParent = nc_varget(parentFile,'lon_rho');
hParent   = nc_varget(parentFile,'h');
maskParent   = nc_varget(parentFile,'mask_rho');

latSubgrid = nc_varget(subFile,'lat_rho');
lonSubgrid = nc_varget(subFile,'lon_rho');
hSubgrid   = nc_varget(subFile,'h');

latMin = min(latSubgrid(:));
latMax = max(latSubgrid(:));
lonMin = min(lonSubgrid(:));
lonMax = max(lonSubgrid(:));

fig(1);pcolor(lonParent,latParent,maskParent);shading flat
hold on
plot([lonMin lonMax],[latMin latMin])
plot([lonMin lonMax],[latMax latMax])
plot([lonMin lonMin],[latMin latMax])
plot([lonMax lonMax],[latMin latMax])

